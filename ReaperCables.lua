navX = 0
navY = 0
isDragging = false
dragX = 0
dragY = 0
gfx.init("Test",1000,750,0,0,0)

function getAllTrackNames()
  list = {}
  for i=0,reaper.GetNumTracks()-1 do
    track = reaper.GetTrack(0,i)
    a, list[i] = reaper.GetTrackName(track)
  end
  
  return list
end


function drawBlock(x,y)
  width = 200
  height = 150
  gfx.roundrect(x+navX,y+navY,width,height,10,true)
  gfx.x = x+navX+width/3
  gfx.y = y+navY
  a = false
  list = getAllTrackNames()
  gfx.drawstr(list[1])
end

function update()
  if gfx.mouse_cap == 1 ~= isDragging then
    isDragging = not isDragging
    dragX = gfx.mouse_x
    dragY = gfx.mouse_y
  end
  
  if (isDragging) then
    navX = navX + gfx.mouse_x - dragX
    navY = navY + gfx.mouse_y - dragY
    dragX = gfx.mouse_x
    dragY = gfx.mouse_y
  end
  
  drawBlock(100,100)
  gfx.update()
  reaper.runloop(update)
end

gfx.setfont(1,"Calibri", 20, "")
update()


