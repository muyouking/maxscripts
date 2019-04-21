--try(closeRolloutFloater YFMat);catch()
--try(destroydialog YFMat);catch()
--------------------------------------------------------------------------
--include 

---------------------------------------------------------------------------
try(closeRolloutFloater YFMat);catch()	
	
---------------------------------------------------------------------------
fn ShowRollout = 
	(
	try(closeRolloutFloater YFMat);catch()	
	YFMat = newRolloutFloater "一键给材质" 468 420
	include "OneKeySetMat_M.ms"
	IsMatLibIn = loadMaterialLibrary ((GetDir #scripts)+"\YF_Vary.mat")	--加载YF_Vary.mat
	if (not IsMatLibIn) then messagebox （"请将材质库YF_Vray.mat放在scripts文件夹中"）
	
	addRollout hyq2 YFMat rolledUp:false	
	addRollout YFDefaultRlt YFMat rolledUp:true
	addRollout YFMat1Rlt YFMat rolledUp:true
	addRollout YFMat2Rlt YFMat rolledUp:true
	addRollout YFMat3Rlt YFMat rolledUp:true
	addRollout YFMat4Rlt YFMat rolledUp:true
	addRollout YFMat5Rlt YFMat rolledUp:true		
	--print YFMat.size
	--YFMat.size = [YFMat.size[1],YFDefaultRlt.size[2]]	
	)
------------------------------------------------------------------------
rollout hyq2 "SetMaterial" width:464 height:27
(
	materialButton btn9 "一键给材质" pos:[20,4] width:85 height:17
	
	button btn17 "将材质导入编辑器/下一屏" pos:[297,3] width:145 height:19
		
		----------------------------------------------------------------------------
		
		
		
	on btn9 picked MatTemp do
	(
		
		Set_Mat MatTemp	--调用OneKeySetMat_M.ms 里的Set_Mat 方法
					
			
	)
	on btn17 pressed do
	(
	if MatIndex>AllMats.count then MatIndex=1	--如果将所有的材质都导入一遍之后再按此按扭，将重新导入一次
	LoadNextMat()
		
	)
)
------------------------------------------------------------------------
rollout YFDefaultRlt "常用材质球" width:464 height:264
(
	button YF_taoci "陶瓷" pos:[11,9] width:100 height:20
	button YF_dalishi "大理石" pos:[123,9] width:100 height:20
	button YF_dengzhaobutouming "灯罩不透明" pos:[235,9] width:100 height:20
	button YF_dengdai "灯带" pos:[347,9] width:100 height:20
	button YF_yaguangmucai "哑光木材" pos:[12,40] width:100 height:20
	
	button YF_toumingboli "透明玻璃" pos:[124,40] width:100 height:20
	button YF_baijing "白镜" pos:[236,39] width:100 height:20
	button YF_shui "水" pos:[348,40] width:100 height:20
	button YF_moshajinshu "磨砂金属" pos:[12,72] width:100 height:20
	button YF_liangguangjinshu "亮光金属" pos:[124,72] width:100 height:20
	
	button YF_jinsemoshajinshu "金色磨砂金属" pos:[236,72] width:100 height:20
	button YF_jinshujianmoshajinshu "金属件磨砂金属" pos:[348,72] width:100 height:20
	button YF_yaguangsuliao "哑光塑料" pos:[13,103] width:100 height:20
	button YF_yaguangpige "哑光皮革" pos:[125,103] width:100 height:20
	button YF_pingmu "屏幕" pos:[237,103] width:100 height:20
	
	button YF_heipingmu "黑屏幕" pos:[349,103] width:100 height:20
	button YF_buyi "布艺" pos:[13,134] width:100 height:20
	button YF_rongbu "绒布" pos:[125,134] width:100 height:20
	button btn92 "Button" pos:[237,134] width:100 height:20
	button btn93 "Button" pos:[349,134] width:100 height:20
	
	button YF_shufengmian "书封面" pos:[14,165] width:100 height:20
	button YF_guahua "挂画" pos:[126,165] width:100 height:20
	button btn96 "Button" pos:[238,165] width:100 height:20
	button btn97 "Button" pos:[350,165] width:100 height:20
	button YF_zhiwuhua "植物花" pos:[14,197] width:100 height:20
	
	button YF_zhiwuyezhi "植物叶子" pos:[126,197] width:100 height:20
	button YF_zhiwushupi "植物树皮" pos:[238,197] width:100 height:20
	button btn101 "Button" pos:[350,197] width:100 height:20
	button btn102 "Button" pos:[15,228] width:100 height:20
	button btn103 "Button" pos:[127,228] width:100 height:20
	
	button btn104 "Button" pos:[239,228] width:100 height:20
	button btn105 "Button" pos:[351,228] width:100 height:20
	------------------------------------------------------------------------
	on YF_taoci pressed do ( Set_Mat (SetMat_FromName "YF_taoci"))
	on YF_dalishi pressed do ( Set_Mat (SetMat_FromName "YF_dalishi"))
	on YF_dengzhaobutouming pressed do ( Set_Mat (SetMat_FromName "YF_dengzhaobutouming"))
	on YF_dengdai pressed do ( Set_Mat (SetMat_FromName "YF_dengdai"))
	on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	
	on YF_toumingboli pressed do ( Set_Mat (SetMat_FromName "YF_toumingboli"))
	on YF_baijing pressed do ( Set_Mat (SetMat_FromName "YF_baijing"))
	on YF_shui pressed do ( Set_Mat (SetMat_FromName "YF_shui"))
	on YF_moshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_moshajinshu"))
	on YF_liangguangjinshu pressed do ( Set_Mat (SetMat_FromName "YF_liangguangjinshu"))
	
	on YF_jinsemoshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_jinsemoshajinshu"))
	on YF_jinshujianmoshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_jinshujianmoshajinshu"))
	on YF_yaguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_yaguangsuliao"))
	on YF_yaguangpige pressed do ( Set_Mat (SetMat_FromName "YF_yaguangpige"))
	on YF_pingmu pressed do ( Set_Mat (SetMat_FromName "YF_pingmu"))
	
	on YF_heipingmu pressed do ( Set_Mat (SetMat_FromName "YF_heipingmu"))
	on YF_buyi pressed do ( Set_Mat (SetMat_FromName "YF_buyi"))
	on YF_rongbu pressed do ( Set_Mat (SetMat_FromName "YF_rongbu"))
	--on btn92 pressed do ( Set_Mat (SetMat_FromName "btn92"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	
	on YF_shufengmian pressed do ( Set_Mat (SetMat_FromName "YF_shufengmian"))
	on YF_guahua pressed do ( Set_Mat (SetMat_FromName "YF_guahua"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	on YF_zhiwuhua pressed do ( Set_Mat (SetMat_FromName "YF_zhiwuhua"))
	
	on YF_zhiwuyezhi pressed do ( Set_Mat (SetMat_FromName "YF_zhiwuyezhi"))
	on YF_zhiwushupi pressed do ( Set_Mat (SetMat_FromName "YF_zhiwushupi"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	--on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	
	
)
------------------------------------------------------------------------
rollout YFMat1Rlt "木材" width:456 height:141
(
	GroupBox grp_wood "木材" pos:[8,2] width:432 height:118
	button YF_yaguangmucai "哑光木材" pos:[40,23] width:100 height:20
	button YF_loukongliangguangmucai "镂空亮光木材" pos:[173,56] width:100 height:20
	button YF_yaguangshimu "哑光实木" pos:[306,24] width:100 height:20
	button YF_loukongyaguangmucai "镂空哑光木材" pos:[40,55] width:100 height:20	
	button YF_liangguangmucai "亮光木材" pos:[173,24] width:100 height:20
	button YF_loukongzhiwu "镂空植物" pos:[306,56] width:100 height:20
	button YF_zhiwuyezhi "植物叶子" pos:[173,88] width:100 height:20
	button YF_zhiwushupi "植物树皮" pos:[40,87] width:100 height:20
	button YF_zhiwuhua "植物花" pos:[306,88] width:100 height:20
	
	------------------------------------------------------------------------------
	on YF_yaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_yaguangmucai"))
	on YF_loukongliangguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_loukongliangguangmucai"))
	on YF_yaguangshimu pressed do ( Set_Mat (SetMat_FromName "YF_yaguangshimu"))
	on YF_loukongyaguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_loukongyaguangmucai"))
	on YF_liangguangmucai pressed do ( Set_Mat (SetMat_FromName "YF_liangguangmucai"))
	on YF_loukongzhiwu pressed do ( Set_Mat (SetMat_FromName "YF_loukongzhiwu"))
	on YF_zhiwuyezhi pressed do ( Set_Mat (SetMat_FromName "YF_zhiwuyezhi"))
	on YF_zhiwushupi pressed do ( Set_Mat (SetMat_FromName "YF_zhiwushupi"))
	on YF_zhiwuhua pressed do ( Set_Mat (SetMat_FromName "YF_zhiwuhua"))
	
)
------------------------------------------------------------------------

rollout YFMat2Rlt "金属" width:456 height:104
(
	GroupBox grp_wood "金属" pos:[8,2] width:432 height:87
	button YF_moshajinshu "磨砂金属" pos:[40,23] width:100 height:20
	button YF_loukongmoshajinshu "镂空磨砂金属" pos:[173,56] width:100 height:20
	button YF_jinsemoshajinshu "金色磨砂金属" pos:[306,24] width:100 height:20
	button YF_jinshujianmoshajinshu "金属件磨砂金属" pos:[40,55] width:100 height:20
	button YF_liangguangjinshu "亮光金属" pos:[173,24] width:100 height:20
	button YF_loukongliangguangjinshu "镂空亮光金属" pos:[306,56] width:100 height:20
	
	------------------------------------------------------------------------------
	on YF_moshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_moshajinshu"))
	on YF_loukongmoshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_loukongmoshajinshu"))
	on YF_jinsemoshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_jinsemoshajinshu"))
	on YF_jinshujianmoshajinshu pressed do ( Set_Mat (SetMat_FromName "YF_jinshujianmoshajinshu"))
	on YF_liangguangjinshu pressed do ( Set_Mat (SetMat_FromName "YF_liangguangjinshu"))
	on YF_loukongliangguangjinshu pressed do ( Set_Mat (SetMat_FromName "YF_loukongliangguangjinshu"))
)
------------------------------------------------------------------------

rollout YFMat3Rlt "塑料-皮革-布-纱" width:456 height:256
(
	GroupBox grp_wood "塑料" pos:[8,2] width:432 height:86
	button YF_yaguangsuliao "哑光塑料" pos:[40,23] width:100 height:20
	button YF_toumingliangguangsuliao "透明亮光塑料" pos:[173,56] width:100 height:20
	button YF_toumingloukongyaguangsuliao "透明镂空哑光塑料" pos:[306,24] width:100 height:20
	button YF_liangguangsuliao "亮光塑料" pos:[40,55] width:100 height:20		
		
	button YF_toumingyaguangsuliao "透明哑光塑料" pos:[173,24] width:100 height:20
	button YF_toumingloukongliangguangsuliao "透明镂空亮光塑料" pos:[306,56] width:100 height:20
	button YF_liangguangpige "亮光皮革" pos:[173,117] width:100 height:20
	button YF_yaguangpige "哑光皮革" pos:[40,116] width:100 height:20
	button YF_sichou "丝绸" pos:[306,117] width:100 height:20
	GroupBox grp11 "皮革-布艺" pos:[8,97] width:432 height:143
	button YF_dengzhaotouming "灯罩透明" pos:[173,204] width:100 height:20
	button YF_dengzhaobutouming "灯罩不透明" pos:[40,203] width:100 height:20
	button YF_ruanbao "软包" pos:[306,204] width:100 height:20
	button YF_rongbu "绒布" pos:[173,145] width:100 height:20
	button YF_buyi "布艺" pos:[40,144] width:100 height:20
	button YF_loukongbuyi "镂空布艺" pos:[306,145] width:100 height:20
	button YF_tuansha "图案纱" pos:[173,174] width:100 height:20
	button YF_sha "纱" pos:[40,173] width:100 height:20
	button YF_ditan "地毯" pos:[306,174] width:100 height:20
	------------------------------------------------------------------------------
	on YF_yaguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_yaguangsuliao"))	
	on YF_toumingliangguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_toumingliangguangsuliao"))
	on YF_toumingloukongyaguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_toumingloukongyaguangsuliao"))
	on YF_liangguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_liangguangsuliao"))
		
	on YF_toumingyaguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_toumingyaguangsuliao"))
	on YF_toumingloukongliangguangsuliao pressed do ( Set_Mat (SetMat_FromName "YF_toumingloukongliangguangsuliao"))	
	on YF_liangguangpige pressed do ( Set_Mat (SetMat_FromName "YF_liangguangpige"))
	on YF_yaguangpige pressed do ( Set_Mat (SetMat_FromName "YF_yaguangpige"))
	on YF_sichou pressed do ( Set_Mat (SetMat_FromName "YF_sichou"))
	on YF_dengzhaotouming pressed do ( Set_Mat (SetMat_FromName "YF_dengzhaotouming"))
	on YF_dengzhaobutouming pressed do ( Set_Mat (SetMat_FromName "YF_dengzhaobutouming"))
	on YF_ruanbao pressed do ( Set_Mat (SetMat_FromName "YF_ruanbao"))
	on YF_rongbu pressed do ( Set_Mat (SetMat_FromName "YF_moshajinshu"))
	on YF_buyi pressed do ( Set_Mat (SetMat_FromName "YF_buyi"))
	on YF_loukongbuyi pressed do ( Set_Mat (SetMat_FromName "YF_loukongbuyi"))
	on YF_tuansha pressed do ( Set_Mat (SetMat_FromName "YF_moshajinshu"))
	on YF_sha pressed do ( Set_Mat (SetMat_FromName "YF_sha"))
	on YF_ditan pressed do ( Set_Mat (SetMat_FromName "YF_ditan"))
)
------------------------------------------------------------------------

rollout YFMat4Rlt "玻璃-水-镜子-屏幕" width:456 height:264
(
	GroupBox grp_wood "玻璃" pos:[13,8] width:432 height:118
	GroupBox grp13 "水-镜子-屏幕" pos:[13,134] width:432 height:118
	
	button YF_toumingboli "透明玻璃" pos:[44,29] width:100 height:20
	button YF_heiboli "黑玻璃" pos:[180,62] width:100 height:20
	button YF_butoummoshaboli "不透明磨砂玻璃" pos:[316,30] width:100 height:20
	button YF_chuanghutoumingboli "窗户透明玻璃" pos:[44,61] width:100 height:20		
	button YF_moshaboli "磨砂玻璃" pos:[180,30] width:100 height:20
	
	button YF_zhezhaoboli "遮罩玻璃" pos:[316,62] width:100 height:20	
	button YF_chajiboli "茶几玻璃" pos:[44,93] width:100 height:20
	button YF_caiseboli "彩色玻璃" pos:[180,94] width:100 height:20	
	button YF_baijing "白镜" pos:[44,151] width:100 height:20
	button YF_chajing "茶镜" pos:[316,151] width:100 height:20
	
	button YF_heijing "黑镜" pos:[180,151] width:100 height:20
	button YF_shui "水" pos:[44,182] width:100 height:20
	button YF_shuijing "水晶" pos:[316,94] width:100 height:20
	button YF_hongjiu "红酒" pos:[180,182] width:100 height:20
	button YF_hongjiuping "红酒瓶" pos:[316,182] width:100 height:20
	
	button YF_pingmu "屏幕" pos:[180,214] width:100 height:20
	button YF_heipingmu "黑屏幕" pos:[316,214] width:100 height:20
	button YF_dengdai "灯带" pos:[44,214] width:100 height:20
	------------------------------------------------------------------------------
	on YF_toumingboli pressed do ( Set_Mat (SetMat_FromName "YF_toumingboli"))
	on YF_heiboli pressed do ( Set_Mat (SetMat_FromName "YF_heiboli"))
	on YF_butoummoshaboli pressed do ( Set_Mat (SetMat_FromName "YF_butoummoshaboli"))
	on YF_chuanghutoumingboli pressed do ( Set_Mat (SetMat_FromName "YF_chuanghutoumingboli"))
	on YF_moshaboli pressed do ( Set_Mat (SetMat_FromName "YF_moshaboli"))
		
	on YF_zhezhaoboli pressed do ( Set_Mat (SetMat_FromName "YF_zhezhaoboli"))		
	on YF_chajiboli pressed do ( Set_Mat (SetMat_FromName "YF_chajiboli"))
	on YF_caiseboli pressed do ( Set_Mat (SetMat_FromName "YF_caiseboli"))
	on YF_baijing pressed do ( Set_Mat (SetMat_FromName "YF_baijing"))
	on YF_chajing pressed do ( Set_Mat (SetMat_FromName "YF_chajing"))
		
	on YF_heijing pressed do ( Set_Mat (SetMat_FromName "YF_heijing"))
	on YF_shui pressed do ( Set_Mat (SetMat_FromName "YF_shui"))
	on YF_shuijing pressed do ( Set_Mat (SetMat_FromName "YF_shuijing"))
	on YF_hongjiu pressed do ( Set_Mat (SetMat_FromName "YF_hongjiu"))
	on YF_hongjiuping pressed do ( Set_Mat (SetMat_FromName "YF_hongjiuping"))
		
	on YF_pingmu pressed do ( Set_Mat (SetMat_FromName "YF_pingmu"))
	on YF_heipingmu pressed do ( Set_Mat (SetMat_FromName "YF_heipingmu"))
	on YF_dengdai pressed do ( Set_Mat (SetMat_FromName "YF_dengdai"))
	

)
------------------------------------------------------------------------

rollout YFMat5Rlt "硬装材质" width:456 height:376
(
	GroupBox grp_wood "石材" pos:[8,2] width:432 height:150
	GroupBox grp20 "其它" pos:[8,297] width:432 height:71
	GroupBox grp22 "墙-地板" pos:[8,152] width:432 height:144
	
	button YF_taoci "陶瓷" pos:[40,23] width:100 height:20
	button YF_masaike "马赛克" pos:[173,55] width:100 height:20
	button YF_wenhuashi "文化石" pos:[306,24] width:100 height:20
	button YF_dalishi "大理石" pos:[40,54] width:100 height:20
	button YF_chutao "粗陶" pos:[173,24] width:100 height:20
	
	button YF_putongcizhuan "普通瓷砖" pos:[306,55] width:100 height:20
	button YF_paoguangzhuan "抛光砖" pos:[173,87] width:100 height:20
	button YF_yaguangzhuan "哑光砖" pos:[40,86] width:100 height:20
	button YF_gaofanshezhuan "高反射砖" pos:[306,87] width:100 height:20
	button YF_kaoqi "烤漆" pos:[173,312] width:100 height:20
	
	button YF_guahua "挂画" pos:[40,311] width:100 height:20
	button YF_yaguangshufengmian "哑光书封面" pos:[173,343] width:100 height:20
	button YF_shufengmian "书封面" pos:[40,342] width:100 height:20
	button YF_guizaoni "硅藻泥" pos:[40,201] width:100 height:20
	button YF_fudiao "浮雕" pos:[306,116] width:100 height:20
	
	button YF_tuliao "涂料" pos:[173,119] width:100 height:20
	button YF_yaguangqiangzhi "哑光墙纸" pos:[173,171] width:100 height:20
	button YF_putongqiangzhi "普通墙纸" pos:[40,170] width:100 height:20
	button YF_fansheqiangzhi "反射墙纸" pos:[306,171] width:100 height:20
	button YF_fansheguizaoni "反射硅藻泥" pos:[306,202] width:100 height:20
	
	button YF_aotuguizaoni "凹凸硅藻泥" pos:[173,201] width:100 height:20
	button YF_baiqiang "白墙" pos:[40,120] width:100 height:20
	button YF_liangguangdiban "亮光地板" pos:[173,231] width:100 height:20
	button YF_zidingyi "自定义" pos:[306,312] width:100 height:20
	button YF_yaguangdiban "哑光地板" pos:[40,231] width:100 height:20
	
	button YF_yaguangkouban "哑光扣板" pos:[173,262] width:100 height:20
	button YF_liangguangkouban "亮光扣板" pos:[306,261] width:100 height:20
	button YF_yaguangqiangban "哑光墙板" pos:[40,262] width:100 height:20
	button YF_liangguangqianban "亮光墙板" pos:[306,231] width:100 height:20
	
	------------------------------------------------------------------------------
	on YF_taoci pressed do ( Set_Mat (SetMat_FromName "YF_taoci"))
	on YF_masaike pressed do ( Set_Mat (SetMat_FromName "YF_masaike"))
	on YF_wenhuashi pressed do ( Set_Mat (SetMat_FromName "YF_wenhuashi"))
	on YF_dalishi pressed do ( Set_Mat (SetMat_FromName "YF_dalishi"))
	on YF_chutao pressed do ( Set_Mat (SetMat_FromName "YF_chutao"))
		
	on YF_putongcizhuan pressed do ( Set_Mat (SetMat_FromName "YF_putongcizhuan"))
	on YF_paoguangzhuan pressed do ( Set_Mat (SetMat_FromName "YF_paoguangzhuan"))
	on YF_yaguangzhuan pressed do ( Set_Mat (SetMat_FromName "YF_yaguangzhuan"))
	on YF_gaofanshezhuan pressed do ( Set_Mat (SetMat_FromName "YF_gaofanshezhuan"))
	on YF_kaoqi pressed do ( Set_Mat (SetMat_FromName "YF_kaoqi"))
	
	on YF_guahua pressed do ( Set_Mat (SetMat_FromName "YF_guahua"))
	on YF_yaguangshufengmian pressed do ( Set_Mat (SetMat_FromName "YF_yaguangshufengmian"))
	on YF_shufengmian pressed do ( Set_Mat (SetMat_FromName "YF_shufengmian"))
	on YF_guizaoni pressed do ( Set_Mat (SetMat_FromName "YF_guizaoni"))
	on YF_fudiao pressed do ( Set_Mat (SetMat_FromName "YF_fudiao"))
	
	on YF_tuliao pressed do ( Set_Mat (SetMat_FromName "YF_tuliao"))
	on YF_yaguangqiangzhi pressed do ( Set_Mat (SetMat_FromName "YF_yaguangqiangzhi"))
	on YF_putongqiangzhi pressed do ( Set_Mat (SetMat_FromName "YF_putongqiangzhi"))
	on YF_fansheqiangzhi pressed do ( Set_Mat (SetMat_FromName "YF_fansheqiangzhi"))
	on YF_fansheguizaoni pressed do ( Set_Mat (SetMat_FromName "YF_fansheguizaoni"))
	
	on YF_aotuguizaoni pressed do ( Set_Mat (SetMat_FromName "YF_aotuguizaoni"))
	on YF_baiqiang pressed do ( Set_Mat (SetMat_FromName "YF_baiqiang"))
	on YF_liangguangdiban pressed do ( Set_Mat (SetMat_FromName "YF_liangguangdiban"))
	on YF_zidingyi pressed do ( Set_Mat (SetMat_FromName "YF_zidingyi"))
	on YF_yaguangdiban pressed do ( Set_Mat (SetMat_FromName "YF_yaguangdiban"))
	
	on YF_yaguangkouban pressed do ( Set_Mat (SetMat_FromName "YF_yaguangkouban"))
	on YF_liangguangkouban pressed do ( Set_Mat (SetMat_FromName "YF_liangguangkouban"))
	on YF_yaguangqiangban pressed do ( Set_Mat (SetMat_FromName "YF_yaguangqiangban"))
	on YF_liangguangqianban pressed do ( Set_Mat (SetMat_FromName "YF_liangguangqianban"))
	
)
------------------------------------------------------------------------
	YFMat = newRolloutFloater "一键给材质" 468 420
	include "OneKeySetMat_M.ms"
	IsMatLibIn = loadMaterialLibrary ((GetDir #scripts)+"\YF_Vary.mat")	--加载YF_Vary.mat
	if (not IsMatLibIn) then messagebox （"请将材质库YF_Vray.mat放在scripts文件夹中"）
	
	addRollout hyq2 YFMat rolledUp:false	
	addRollout YFDefaultRlt YFMat rolledUp:true
	addRollout YFMat1Rlt YFMat rolledUp:true
	addRollout YFMat2Rlt YFMat rolledUp:true
	addRollout YFMat3Rlt YFMat rolledUp:true
	addRollout YFMat4Rlt YFMat rolledUp:true
	addRollout YFMat5Rlt YFMat rolledUp:true
--ShowRollout()