return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 27,
  height = 24,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 30,
  backgroundcolor = { 241, 89, 40 },
  properties = {
    ["music"] = "videofields",
    ["name"] = "Videofields - Entrance"
  },
  tilesets = {
    {
      name = "videofields",
      firstgid = 1,
      class = "",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 13,
      image = "../../../assets/sprites/tilesets/videofields.png",
      imagewidth = 520,
      imageheight = 760,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 40,
        height = 40
      },
      properties = {},
      wangsets = {},
      tilecount = 247,
      tiles = {
        {
          id = 79,
          animation = {
            {
              tileid = 79,
              duration = 200
            },
            {
              tileid = 83,
              duration = 200
            },
            {
              tileid = 87,
              duration = 200
            },
            {
              tileid = 109,
              duration = 200
            }
          }
        },
        {
          id = 80,
          animation = {
            {
              tileid = 80,
              duration = 200
            },
            {
              tileid = 84,
              duration = 200
            },
            {
              tileid = 88,
              duration = 200
            },
            {
              tileid = 110,
              duration = 200
            }
          }
        },
        {
          id = 81,
          animation = {
            {
              tileid = 81,
              duration = 200
            },
            {
              tileid = 85,
              duration = 200
            },
            {
              tileid = 89,
              duration = 200
            },
            {
              tileid = 111,
              duration = 200
            }
          }
        },
        {
          id = 82,
          animation = {
            {
              tileid = 82,
              duration = 200
            },
            {
              tileid = 86,
              duration = 200
            },
            {
              tileid = 90,
              duration = 200
            },
            {
              tileid = 112,
              duration = 200
            }
          }
        },
        {
          id = 92,
          animation = {
            {
              tileid = 92,
              duration = 200
            },
            {
              tileid = 96,
              duration = 200
            },
            {
              tileid = 100,
              duration = 200
            },
            {
              tileid = 122,
              duration = 200
            }
          }
        },
        {
          id = 93,
          animation = {
            {
              tileid = 93,
              duration = 200
            },
            {
              tileid = 97,
              duration = 200
            },
            {
              tileid = 101,
              duration = 200
            },
            {
              tileid = 123,
              duration = 200
            }
          }
        },
        {
          id = 94,
          animation = {
            {
              tileid = 94,
              duration = 200
            },
            {
              tileid = 98,
              duration = 200
            },
            {
              tileid = 102,
              duration = 200
            },
            {
              tileid = 124,
              duration = 200
            }
          }
        },
        {
          id = 95,
          animation = {
            {
              tileid = 95,
              duration = 200
            },
            {
              tileid = 99,
              duration = 200
            },
            {
              tileid = 103,
              duration = 200
            },
            {
              tileid = 125,
              duration = 200
            }
          }
        }
      }
    },
    {
      name = "videofieldsDecor",
      firstgid = 248,
      filename = "../tilesets/videofieldsDecor.tsx"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/parallax/videofield_frames.png",
      id = 7,
      name = "frames",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 840,
      offsety = 40,
      parallaxx = 0.1,
      parallaxy = 0.1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 1
      }
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/parallax/videofield_frames.png",
      id = 8,
      name = "frames2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 880,
      offsety = 80,
      parallaxx = 0.1,
      parallaxy = 0.1,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = -1
      }
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/parallax/videofield_nightsky.png",
      id = 5,
      name = "nightsky",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 320,
      offsety = 40,
      parallaxx = 0.25,
      parallaxy = 0.25,
      repeatx = true,
      repeaty = false,
      properties = {
        ["speedx"] = 0.5
      }
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/parallax/videofield_sky.png",
      id = 4,
      name = "sky",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = -120,
      offsety = 120,
      parallaxx = 0.5,
      parallaxy = 0.5,
      repeatx = true,
      repeaty = false,
      properties = {}
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/parallax/videofield_parallax.png",
      id = 3,
      name = "parallax",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 120,
      offsety = 280,
      parallaxx = 0.75,
      parallaxy = 0.75,
      repeatx = true,
      repeaty = false,
      properties = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 27,
      height = 24,
      id = 1,
      name = "tiles",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        4, 4, 4, 4, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        17, 17, 17, 17, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        30, 30, 30, 30, 30, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        44, 40, 40, 40, 42, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        57, 53, 53, 53, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        57, 53, 53, 53, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        57, 53, 53, 53, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        57, 53, 53, 53, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        57, 66, 66, 66, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        4, 17, 17, 17, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 0, 0, 0, 0, 3, 4, 4, 4, 4, 4, 4, 4, 4,
        17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 0, 0, 0, 0, 16, 17, 17, 17, 17, 17, 17, 17, 17,
        30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 17, 17, 17, 4, 4, 4, 4, 17, 17, 17, 30, 30, 30, 30, 30, 30,
        43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 43, 16, 17, 17, 17, 17, 17, 17, 17, 17, 18, 43, 43, 43, 43, 43, 43,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 16, 30, 30, 30, 30, 30, 30, 30, 30, 31, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 42, 43, 43, 43, 43, 43, 43, 43, 43, 44, 56, 56, 56, 56, 56, 56
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 27,
      height = 24,
      id = 2,
      name = "tiles2",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 80, 81, 82, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 93, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 106, 107, 108, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 80, 81, 82, 83, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 120, 121, 0, 0, 0, 0, 0, 0, 0, 106, 107, 108, 109, 0, 0, 80, 81, 82, 83, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 8, 0, 0, 0, 0, 0, 120, 0, 0, 0, 6, 8, 0, 0, 0, 0,
        0, 0, 0, 0, 6, 7, 7, 8, 0, 0, 32, 34, 0, 0, 0, 0, 0, 120, 0, 0, 0, 32, 34, 0, 0, 6, 8,
        0, 0, 0, 0, 32, 33, 33, 34, 0, 0, 0, 0, 6, 7, 7, 8, 0, 6, 8, 0, 0, 0, 0, 0, 0, 32, 34,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 20, 20, 21, 0, 32, 34, 0, 0, 0, 0, 0, 0, 0, 0,
        45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0, 32, 33, 33, 34, 0, 0, 0, 0, 0, 45, 45, 45, 45, 45, 45,
        58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 58, 58, 58, 58, 58
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 27,
      height = 24,
      id = 6,
      name = "decor",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 47, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 48, 0, 0, 0,
        0, 0, 60, 61, 0, 47, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 61, 0, 0, 0,
        0, 0, 73, 74, 0, 60, 61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 74, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 255, 0, 0 },
      properties = {},
      objects = {
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 680,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 720,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 680,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 840,
          width = 240,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 840,
          width = 440,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 920,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 360,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 480,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 11,
          name = "spawn",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "paths",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "drawgon",
          type = "",
          shape = "ellipse",
          x = 720,
          y = 760,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 800,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "drawgon",
            ["chase"] = false,
            ["encounter"] = "bookworm n drawgon",
            ["path"] = "drawgon",
            ["progress"] = "-0.1"
          }
        },
        {
          id = 3,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 800,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "slidearea",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 480,
          width = 120,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["dust"] = "effects/slide_sand"
          }
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 760,
          width = 80,
          height = 120,
          rotation = 0,
          gid = 248,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 760,
          width = 80,
          height = 120,
          rotation = 0,
          gid = 248,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 400,
          width = 80,
          height = 120,
          rotation = 0,
          gid = 248,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 760,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 11,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 920,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 11,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 920,
          y = 760,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 11,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 800,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 11,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 720,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "videofields_4",
            ["marker"] = "1"
          }
        }
      }
    }
  }
}
