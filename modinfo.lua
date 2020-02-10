name = "Path Lights EX"
version = "1.0.1.3"
description = [[
落地路灯(Path Lights)EX版 1.0

※MOD制作初心者
改自Afro1967的原版: https://steamcommunity.com/sharedfiles/filedetails/?id=385006082

特性: 
·除4种预设颜色外, 增加4096色RGB模式
·右键灯可以切换常亮/智能/熄灭三种状态
·可以使用荧光珠代替萤火虫, 在MOD配置中修改
]]
author = "donmor; Afro1967"
forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 
icon_atlas = "path_light.xml"
icon = "path_light.tex"
server_filter_tags = {
	"item", "utility",
}

configuration_options =
{
	-- {	
		-- name = "menu_divider1",
		-- label = "基本配置",
		-- options =
		-- {	
			-- { description = "", data = false },
		-- },
		-- default = false,
	-- }, 

	{
		name = "recipe",
		label = "制作配方",
		options =
		{
			{description = "简单", data = "easy", hover = "1石头+3树枝+1萤火虫/萤光珠+1绳子"},
			{description = "普通", data = "normal", hover = "1月亮石+3树枝+1萤火虫/萤光珠+1绳子"},
			{description = "困难", data = "hard", hover = "2月亮石+3树枝+1萤火虫/萤光珠+2绳子"},
		},
		default = "normal",
	},

	{
		name = "fragile",
		label = "坚固程度",
		options =
		{
			{description = "易碎", data = true, hover = "可被攻击且一击即碎"},
			{description = "一般", data = false, hover = "需要用锤子打击一次拆毁"},
		},
		default = true,
	},

	{
		name = "recipe_use_firefly",
		label = "配方关键材料",
		options =
		{
			{description = "萤火虫", data = true},
			{description = "萤光珠", data = false},
		},
		default = true,
	},

	{
		name = "FueledLights",
		label = "需要燃料",
		options =
		{
			{description = "启用", data = true},
			{description = "禁用", data = false},
		},
		default = false,
	},

	{
		name = "light_radius",
		label = "灯光范围",
		options =
		{
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},			
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
		},
		default = 5,
	},

	-- {
		-- name = "light_intensity",
		-- label = "灯光强度",
		-- options =
		-- {
			-- {description = "1", data = 17},
			-- {description = "2", data = 34},
			-- {description = "3", data = 51},
			-- {description = "4", data = 68},			
			-- {description = "5", data = 85},
			-- {description = "6", data = 102},
			-- {description = "7", data = 119},
			-- {description = "8", data = 136},			
			-- {description = "9", data = 153},
			-- {description = "10", data = 170},
			-- {description = "11", data = 187},
			-- {description = "12", data = 204},			
			-- {description = "13", data = 221},
			-- {description = "14", data = 238},
			-- {description = "15", data = 255},
		-- },
		-- default = 170,
	-- },

	{
		name = "light_custom",
		label = "灯光模式",
		options =
		{
			{description = "预置", data = false},
			{description = "自定义", data = true},
		},
		default = false,
	},

	-- {	
		-- name = "menu_divider2",
		-- label = "预置灯光",
		-- options =
		-- {	
			-- { description = "", data = false },
		-- },
		-- default = false,
	-- }, 

	{
		name = "light_color",
		label = "预置灯光颜色",
		options =
		{
			{description = "蓝色", data = 1},
			{description = "红色", data = 2},
			{description = "绿色", data = 3},
			{description = "白色", data = 4},			
		},
		default = 1,
	},

	-- {
		-- name = "menu_divider3",
		-- label = "自定义灯光",
		-- options =
		-- {	
			-- { description = "", data = false },
		-- },
		-- default = false,
	-- },

	{
		name = "custom_R",
		label = "自定义灯光颜色: 红",
		options =
		{
			{description = "0", data = 0},
			{description = "1", data = 17},
			{description = "2", data = 34},
			{description = "3", data = 51},
			{description = "4", data = 68},			
			{description = "5", data = 85},
			{description = "6", data = 102},
			{description = "7", data = 119},
			{description = "8", data = 136},			
			{description = "9", data = 153},
			{description = "10", data = 170},
			{description = "11", data = 187},
			{description = "12", data = 204},			
			{description = "13", data = 221},
			{description = "14", data = 238},
			{description = "15", data = 255},
		},
		default = 0,
	}, 

	{
		name = "custom_G",
		label = "自定义灯光颜色: 绿",
		options =
		{
			{description = "0", data = 0},
			{description = "1", data = 17},
			{description = "2", data = 34},
			{description = "3", data = 51},
			{description = "4", data = 68},			
			{description = "5", data = 85},
			{description = "6", data = 102},
			{description = "7", data = 119},
			{description = "8", data = 136},			
			{description = "9", data = 153},
			{description = "10", data = 170},
			{description = "11", data = 187},
			{description = "12", data = 204},			
			{description = "13", data = 221},
			{description = "14", data = 238},
			{description = "15", data = 255},
		},
		default = 0,
	}, 

	{
		name = "custom_B",
		label = "自定义灯光颜色: 蓝",
		options =
		{
			{description = "0", data = 0},
			{description = "1", data = 17},
			{description = "2", data = 34},
			{description = "3", data = 51},
			{description = "4", data = 68},			
			{description = "5", data = 85},
			{description = "6", data = 102},
			{description = "7", data = 119},
			{description = "8", data = 136},			
			{description = "9", data = 153},
			{description = "10", data = 170},
			{description = "11", data = 187},
			{description = "12", data = 204},			
			{description = "13", data = 221},
			{description = "14", data = 238},
			{description = "15", data = 255},
		},
		default = 0,
	}
}