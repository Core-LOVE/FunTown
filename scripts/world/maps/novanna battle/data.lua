return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 1,
  backgroundcolor = { 241, 89, 40 },
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "Слой тайлов 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/parallax/videofield_farsky.png",
      id = 7,
      name = "farclouds",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = -80,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 2
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/parallax/videofield_frames.png",
      id = 5,
      name = "frame",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = -40,
      offsety = 280,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 6
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/parallax/videofield_frames.png",
      id = 6,
      name = "frame2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = -40,
      offsety = 240,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = -6
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/parallax/videofield_sky.png",
      id = 3,
      name = "below",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 80,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 8
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/parallax/videofield_nightsky.png",
      id = 4,
      name = "above",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = -80,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 4
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
