navX = 0
navY = 0
isDragging = false
dragX = 0
dragY = 0

Block = {x = 0, y = 0, name = ""}

function Block:new (x,y,name)
  block = {}
  block.x = x
  block.y = y
  block.name = name
  return block
end

blocks = {}

function getAllTrackNames()
  list = {}
  for i=0,reaper.GetNumTracks()-1 do
    track = reaper.GetTrack(0,i)
    a, list[i+1] = reaper.GetTrackName(track)
  end
  
  return list
end

function toMenuString(strings)
  text = ""
  
  for i=1, #strings do
    text = text .. strings[i] .. "|"
  end
  
  return text
end


function drawBlock(x,y,name)
  width = 200
  height = 150
  gfx.roundrect(x+navX,y+navY,width,height,10,true)
  gfx.x = x+navX+width/3
  gfx.y = y+navY
  gfx.drawstr(name)
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
  
  if gfx.mouse_cap == 2 then
    gfx.x = gfx.mouse_x
    gfx.y = gfx.mouse_y
    trackNames = getAllTrackNames()
    t = gfx.showmenu(toMenuString(trackNames))
    if t > 0 then
      table.insert(blocks, Block:new(gfx.mouse_x, gfx.mouse_y, trackNames[t]))
    end
  end
  
  for i = 1, #blocks do
    drawBlock(blocks[i].x, blocks[i].y, blocks[i].name)
  end
  
  gfx.update()
  reaper.runloop(update)
end

gfx.init("Test",1000,750,0,0,0)
gfx.setfont(1,"Calibri", 20, "")
update()


