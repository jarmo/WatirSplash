module Win32
  module Screenshot

    # added patches by Tony Popiel for fixing the problem
    # of failing to take a screenshot of every size of the window
    # http://rubyforge.org/tracker/index.php?func=detail&aid=26216&group_id=2683&atid=10359
    module_function

    def capture(hScreenDC, x1, y1, x2, y2)
      w = x2-x1
      h = y2-y1

      # Reserve some memory
      hmemDC = createCompatibleDC(hScreenDC)
      hmemBM = createCompatibleBitmap(hScreenDC, w, h)
      selectObject(hmemDC, hmemBM)
      bitBlt(hmemDC, 0, 0, w, h, hScreenDC, 0, 0, SRCCOPY)
      # changed line
      # hpxldata = globalAlloc(GMEM_FIXED, w * h * 3)
      hpxldata = globalAlloc(GMEM_FIXED, ((w*h*3)+(w%4)*h))
      lpvpxldata = globalLock(hpxldata)

      # Bitmap header
      # http://www.fortunecity.com/skyscraper/windows/364/bmpffrmt.html
      bmInfo = [40, w, h, 1, 24, 0, 0, 0, 0, 0, 0, 0].pack('LLLSSLLLLLL').to_ptr

      getDIBits(hmemDC, hmemBM, 0, h, lpvpxldata, bmInfo, DIB_RGB_COLORS)

      bmFileHeader = [
              19778,
              # changed line
              # (w * h * 3) + 40 + 14,
              (w * h * 3) + (w%4)*h + 40 + 14,
              0,
              0,
              54
      ].pack('SLSSL').to_ptr

      # changed line
      # data = bmFileHeader.to_s(14) + bmInfo.to_s(40) + lpvpxldata.to_s(w * h * 3)
      data = bmFileHeader.to_s(14) + bmInfo.to_s(40) + lpvpxldata.to_s((w*h*3)+(w%4)*h)

      globalUnlock(hpxldata)
      globalFree(hpxldata)
      deleteObject(hmemBM)
      deleteDC(hmemDC)
      releaseDC(0, hScreenDC)

      return [w, h, data]
    end
  end
end