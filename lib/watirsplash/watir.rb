module Watir
  module PageCheckers
    # raises an error if javascript error was found
    JAVASCRIPT_ERRORS_CHECKER = lambda {|ie| raise "Got JavaScript error!" if ie.status =~ /Error on page/}
  end
end

# patches for Watir
module Watir
  class IE #:nodoc:all
    # This is Watir's overriden wait method, which is used in many places for deciding
    # if browser is ready or not. We have to patch one line in it to work properly
    # when file save as dialog has been displayed. For some reason READYSTATE (4)
    # property value will be READYSTATE_INTERACTIVE (3) after file has been downloaded
    # and not 4, thus wait will stay blocking.
    # read more about IE READYSTATE property:
    # http://msdn.microsoft.com/en-us/library/aa768362(VS.85).aspx
    def wait(no_sleep=false)
      @xml_parser_doc = nil
      @down_load_time = 0.0
      a_moment = 0.2 # seconds
      start_load_time = Time.now

      begin
        while @ie.busy # XXX need to add time out
          sleep a_moment
        end
        # this is the line which has been changed to accept also state 3
        until @ie.readyState <= READYSTATE_COMPLETE do
          sleep a_moment
        end
        sleep a_moment
        until @ie.document do
          sleep a_moment
        end

        documents_to_wait_for = [@ie.document]

      rescue WIN32OLERuntimeError # IE window must have been closed
        @down_load_time = Time.now - start_load_time
        sleep @pause_after_wait unless no_sleep
        return @down_load_time
      end

      while doc = documents_to_wait_for.shift
        begin
          until doc.readyState == "complete" do
            sleep a_moment
          end
          @url_list << doc.location.href unless @url_list.include?(doc.location.href)
          doc.frames.length.times do |n|
            begin
              documents_to_wait_for << doc.frames[n.to_s].document
            rescue WIN32OLERuntimeError, NoMethodError
            end
          end
        rescue WIN32OLERuntimeError
        end
      end

      @down_load_time = Time.now - start_load_time
      run_error_checks
      sleep @pause_after_wait unless no_sleep
      @down_load_time
    end

    # Closes the browser even if #wait throws an exception.
    # It happens mostly when #run_error_checks throws some exception.
    def close
      return unless exists?
      @closing = true
      @ie.stop
      begin
        wait
      rescue
      end
      chwnd = @ie.hwnd.to_i
      @ie.quit
      while Win32API.new("user32", "IsWindow", 'L', 'L').Call(chwnd) == 1
        sleep 0.3
      end
    end
  end

  module PageContainer #:nodoc:all
    # patch for .click_no_wait
    def eval_in_spawned_process(command)
      command.strip!
      ruby_code = "require 'rubygems';"
      ruby_code << "require 'watir/ie';"
      ruby_code << "pc = #{attach_command};"
      ruby_code << "pc.instance_eval(#{command.inspect});"
      exec_string = "start rubyw -e #{ruby_code.inspect}".gsub("\\\"", "'")
      system(exec_string)
    end
  end

  class Table < Element

    # This method returns multi-dimensional array of the cell texts in table.
    #
    # Works with tr, th, td elements, colspan, rowspan and nested tables.
    # Takes an optional parameter *max_depth*, which is by default 1
    def to_a(max_depth=1)
      assert_exists
      y = []
      @o.rows.each do |row|
        y << TableRow.new(@container, :ole_object, row).to_a(max_depth)
      end
      y
    end
  end

  class TableRow < Element

    # This method returns (multi-dimensional) array of the cell texts in table's row.
    #
    # Works with th, td elements, colspan, rowspan and nested tables.
    # Takes an optional parameter *max_depth*, which is by default 1
    def to_a(max_depth=1)
      assert_exists
      y = []
      @o.cells.each do |cell|
        inner_tables = cell.getElementsByTagName("TABLE")
        inner_tables.each do |inner_table|
          # make sure that the inner table is directly child for this cell
          if inner_table?(cell, inner_table)
            max_depth -= 1
            y << Table.new(@container, :ole_object, inner_table).to_a(max_depth) if max_depth >= 1
          end
        end

        if inner_tables.length == 0
          y << cell.innerText.strip
        end
      end
      y
    end

    private
    # returns true if inner_table is direct child
    # table for cell and there's not any table-s in between
    def inner_table?(cell, inner_table)
      parent_element = inner_table.parentElement
      if parent_element.uniqueID == cell.uniqueID
        return true
      elsif parent_element.tagName == "TABLE"
        return false
      else
        return inner_table?(cell, parent_element)
      end
    end
  end
end