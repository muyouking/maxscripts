--------------------------------------------------------------------------------
	global num=1						--材质名后缀
	global AllMats = scenematerials	--收集场景所有材质
	global MatIndex=1					--导入下一页材质球 --材质球计数
	
	------------------------------------------------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------------------------------------------------
	--导入下一页材质球
	fn LoadNextMat =
	(
		AllMatsCount = AllMats.count	--场景材质球数量
		for j=1 to 24 do 
		(
			if AllMatsCount>0 and MatIndex<=AllMatsCount then
			(
				meditMaterials[j]=AllMats[MatIndex]	
				MatIndex = MatIndex+1
			)
			else meditMaterials[j]=Standard()
		
		)
	
	)
	
	------------------------------------------------------------------------------------------------------------------------
		--自定义结构体Mtl
struct HMtl(mtlDiffuse,mtlReflection,mtlRefraction,mtlBump,mtlOpacity)
struct MatColors(diffuse_col,reflection_col,refraction_col,fog_color,light_col)	
	------------------------------------------------------------------------------------------------------------------------
	--去重复
	fn RemoveTheSame List = 
	(
		try
			(
				local  Alist=#()
				
				if List.count>0 then
					(
						for i=1 to List.count do
						(
							local t = 1
							if Alist.count==0 then (append Alist List[i])
							--判断Alist是否有这个List[i]相同的元素
							else if Alist.count>0 then
							(
								for j=1 to Alist.count do
								(
									if List[i]==Alist[j] then( t=0;exit)	--如果有相同元素则将t设为0，并退出这次循环
									
								)
								--如果将List[i]和Alist里的每一个元素对比完了，并没有发现有相同元素，即t还是等于1，则将这个List[i]添加进Alist数组中
								if t==1 do append Alist List[i]
							)
						)
						
					)
				--遍历完了List里的元素后返回Alist
				if (Alist.count>0) then  (sort Alist;return Alist)
			)
		catch()
		
	)	
		
	------------------------------------------------------------------------------------------------------------------------
	--通道过滤 --通道迭代找出贴图路径	
	--MapChannel 通道名
	--MapList 接受贴图路径的数组
	fn Get_MapChannel MapChannel =
	(
		--MapList = #() --清空数组
		--如果这个通道不为空则进行下面的判断
		if classof MapChannel != UndefinedClass do
		(
			
			filepath =case classof MapChannel of (
				--1 
				Bitmaptexture: if MapChannel.filename!=undefined then MapChannel.filename	
				--2
				falloff: Get_MapChannel MapChannel.map1
				--3
				Color_Correction: Get_MapChannel MapChannel.map
				--4
				Mask: Get_MapChannel MapChannel.map				
			)
		)
	
	)
------------------------------------------------------------------------------------------------------------------------
--20190417 hyq添加 获取材质的颜色信息
fn Get_Mat_Color Mat=
(
	local diffuse_col,reflection_col,refraction_col,fog_color,light_col
	case (classof Mat) of
	(
		VRayMtl:(
			print "材质类型为"
			print (classof Mat)
			diffuse_col = Mat.diffuse
			reflection_col = Mat.reflection
			refraction_col = Mat.refraction
			fog_color = Mat.refraction_fogColor
			light_col =Mat.diffuse	-- 漫反射颜色作为发光材质的颜色备用色
			)
		VRayLightMtl:(
			print "材质类型为"
			print (classof Mat)
			----------如果想要获取颜色的材质为灯光材质
			--local default_col =(color 0 0 0)	--默认颜色
			
			--diffuse_col = undefined
			--reflection_col = undefined
			--refraction_col = undefined
			--fog_color = undefined			
			light_col = Mat.color
			
			)
		Standardmaterial:(
			print "材质类型为"
			print (classof Mat)
			diffuse_col = Mat.diffuse
			reflection_col=Mat.specular
			refraction_col=undefined
			fog_color =  undefined
			light_col =if (Mat.useSelfIllumColor == on) then Mat.selfIllumColor
			)
		default:(
			--print "材质类型为"
			--print "想要提取颜色的材质暂不支持"
			diffuse_col = undefined
			reflection_col = undefined
			refraction_col = undefined
			fog_color = undefined			
			light_col = undefined
			)
	)
	print ("diffuse_col:	"+diffuse_col as string)
	print ("reflection_col:	"+reflection_col as string)
	print ("refraction_col:	"+refraction_col as string)
	print ("fog_color:	"+ fog_color as string)
	print ("light_col:	"+light_col as string)
	MatColors_result = MatColors diffuse_col:diffuse_col reflection_col:reflection_col refraction_col:refraction_col fog_color:fog_color light_col:light_col
)
-------------------------------------------------------------------------------------------------------------------------

--201904182211--Set Color
--HMtl 获取到的原材质球的贴图信息
--MatColors 获取到的原材质球的颜色信息
fn Set_Mat_Color HMtl MatColors Mat=
(
	--201904191209，添加判断是特殊材质，抽取颜色，或者抽取漫反射颜色放到反射通道里
	--加多一个判断，如果是falloff通道，而通道里以没有贴图，则将对应通道取的的颜色放到fallof里的颜色里
	--isSetColor = matchpattern Mat.name pattern:"YF_moshajinshu"
	case (classof Mat) of
	(
		VRayMtl:(
			print "材质类型为"
			print (classof Mat)
			if (HMtl.mtlDiffuse ==undefined AND MatColors.diffuse_col!=undefined)  then  Mat.diffuse = MatColors.diffuse_col
			--判断，如果原材质没有漫反射贴图，目标材质的漫反射是falloff通道，则将原材质的漫反射颜色放到目标材质的漫反射颜色，并且目标材质的漫反射通道falloff的两个颜色也设置成这个颜色
			if (HMtl.mtlDiffuse ==undefined AND MatColors.diffuse_col!=undefined AND classof Mat.texmap_diffuse==falloff) then 
			(
				--Mat.texmap_diffuse.color1=MatColors.diffuse_col
				--print "falloff Color"
				--print MatColors.diffuse_col as string
				Mat.texmap_diffuse.color1 = MatColors.diffuse_col
				Mat.texmap_diffuse.color2 = Mat.texmap_diffuse.color1
				)
			--if (HMtl.mtlReflection ==undefined AND  MatColors.reflection_col!=undefined AND Mat.reflection !=(Color 0 0 0) ) then  Mat.reflection = MatColors.reflection_col
			--if (HMtl.mtlRefraction ==undefined  AND  MatColors.refraction_col!=undefined AND Mat.refraction !=(Color 0 0 0)) then  Mat.refraction = MatColors.refraction_col
			--if (HMtl.mtlRefraction == undefined AND Mat.refraction !=(Color 0 0 0) )then  Mat.refraction_fogColor = MatColors.fog_color		--如果材质球的折射refraction 的颜色不等于纯黑色，则将原始材质的fogcolor颜色抽取过来给目标新材质
			--  Mat.selfIllumination = MatColors.light_col		--标准VRayMtl不用抽取原材质的这个颜色，一切以模版里的这个颜色的值为准
		)
		VRayLightMtl:(
			print "材质类型为"
			print (classof Mat)
			----------如果想要获取颜色的材质为灯光材质
			--local default_col =(color 0 0 0)	--默认颜色
			
			--diffuse_col = undefined
			--reflection_col = undefined
			--refraction_col = undefined
			--fog_color = undefined			
			if MatColors.light_col != undefined then Mat.color=MatColors.light_col
			
			)
		Standardmaterial:(
			print "材质类型为"
			print (classof Mat)
			if (HMtl.mtlDiffuse ==undefined AND MatColors.diffuse_col!=undefined ) then Mat.diffuse = MatColors.diffuse_col
			if (HMtl.mtlDiffuse ==undefined AND MatColors.reflection_col!=undefined ) then Mat.specular =MatColors.reflection_col
			--refraction_col=undefined
			--fog_color =  undefined
			if MatColors.light_col != undefined then Mat.selfIllumColor =MatColors.light_col 
			)
	)
)
------------------------------------------------------------------------------------------------------------------------
	--获取Mtl的贴图
fn Get_Map Mtl =
	(	
		if ((superclassof Mtl)!=material) then return Mtl
		matClass= classof Mtl	--获取选择物体的材质类型	VR:VRayMtl； 标准:Standardmaterial；	多维子材质:Multimaterial ；混全材质:Blend
		case matClass of
			(
				--1
				VrayMtl:(print "VrayMtl开始"					
					---漫反射通道
					mtlDiffuse =if Mtl.texmap_diffuse!=undefined then Get_MapChannel Mtl.texmap_diffuse 
					--print mtlDiffuseMap.count
					---凹凸通道			
					mtlBump = if Mtl.texmap_bump!=undefined then Get_MapChannel Mtl.texmap_bump 	
					--print mtlBump.count
					---反射通道
					mtlReflection = if Mtl.texmap_reflection!=undefined then  Get_MapChannel Mtl.texmap_reflection 
					--print mtlReflectionMap.count
					---折射通道
					mtlRefraction = if Mtl.texmap_refraction!=undefined then Get_MapChannel Mtl.texmap_refraction 
					--print mtlRefractionMap.count
					---镂空通道
					mtlOpacity = if Mtl.texmap_opacity!=undefined then Get_MapChannel Mtl.texmap_opacity 
					--print mtlOpacity.count
					)
					
				-------------------------------------------------	
				Standardmaterial:(print "Standardmaterial:"
					---漫反射通道
					mtlDiffuse =if Mtl.diffuseMap!=undefined then Get_MapChannel Mtl.diffuseMap 
					--print mtlDiffuseMap.count
					---凹凸通道			
					mtlBump = if Mtl.bumpMap!=undefined then Get_MapChannel Mtl.bumpMap
					--print mtlBump.count
					---反射通道
					mtlReflection = if Mtl.reflectionMap!=undefined then  Get_MapChannel Mtl.reflectionMap
					--print mtlReflectionMap.count
					---折射通道
					mtlRefraction = if Mtl.refractionMap!=undefined then Get_MapChannel Mtl.refractionMap
					--print mtlRefractionMap.count
					---镂空通道
					mtlOpacity = if Mtl.opacityMap!=undefined then Get_MapChannel Mtl.opacityMap
					
					
					)
				-------------------------------------------------
					
				VRayLightMtl:(print "VRayLightMtl:"
					mtlDiffuse =if Mtl.texmap!=undefined then Get_MapChannel Mtl.texmap 
					)
				-------------------------------------------------	
				Multimaterial:(messagebox "这是一个多维子材质，请处理后再给材质!")
				-------------------------------------------------	
				Blend:(messagebox "这是一个混合材质Blend,请处理后再给材质!")
					
				
				default: return undefined			
			)
		print("mtlDiffuse:"+mtlDiffuse as string )
		print("mtlReflection:"+mtlReflection as string)
		print("mtlRefraction:"+mtlRefraction as string)
		print("mtlBump:"+mtlBump as string)
		print("mtlOpacity:"+mtlOpacity as string)
		HMtl2 = HMtl mtlDiffuse:mtlDiffuse mtlReflection:mtlReflection mtlRefraction:mtlRefraction mtlBump:mtlBump mtlOpacity:mtlOpacity		
	)
	
	
	-----------------------------------------------------------------------------------------------------------------------------
	------给通道赋贴图
	--参数MapChannel	通道名 Mtl.texmap_diffuse 或者Mtl.texmap_refelection
	--filepath:	贴图路径
	fn SetMap MapChannel filepath = 
	(
		if filepath !=undefined then 
		(
			case classof MapChannel of
				(
					Bitmaptexture:MapChannel.filename = filepath
					
					falloff:(MapChannel.map1 = Bitmaptexture fileName:""; MapChannel.map2 = Bitmaptexture fileName:""; SetMap MapChannel.map1 filepath;MapChannel.map2=copy MapChannel.map1 )
					--Mask:
					
				)
		)

	)		
	-----------------------------------------------------------------------------------------------------------------------------
	--对材质球的相关通道进行材质设置
	fn SetChannelMap Mat HMtl =
		(
		--print Mat
		--print (classof Mat)
		case (classof Mat) of
			
			(
				VRayMtl: (
				--1,漫反射
				if (Mat.texmap_diffuse !=undefined ) then SetMap  Mat.texmap_diffuse  HMtl.mtlDiffuse 
				--2,反射 
				if Mat.texmap_reflection !=undefined then SetMap  Mat.texmap_reflection HMtl.mtlReflection
				--3,折射
				if Mat.texmap_refraction !=undefined  then SetMap  Mat.texmap_refraction  HMtl.mtlRefraction
				--4,凹凸 
				if Mat.texmap_bump !=undefined then SetMap  Mat.texmap_bump  HMtl.mtlBump
				--5 镂空
				if Mat.texmap_opacity != undefined  then SetMap  Mat.texmap_opacity  HMtl.mtlOpacity
				)
				Standardmaterial:(print "Standardmaterial:"
				--1,漫反射
				if (Mat.diffuseMap !=undefined ) then SetMap  Mat.diffuseMap  HMtl.mtlDiffuse 
				--2,反射 
				if Mat.reflectionMap !=undefined then SetMap  Mat.reflectionMap HMtl.mtlReflection
				--3,折射
				if Mat.refractionMap !=undefined  then SetMap  Mat.refractionMap  HMtl.mtlRefraction
				--4,凹凸 
				if Mat.bumpMap !=undefined then SetMap  Mat.bumpMap  HMtl.mtlBump
				--5 镂空
				if Mat.opacityMap != undefined  then SetMap  Mat.opacityMap  HMtl.mtlOpacity	
					
				)
				VRayLightMtl:(if (Mat.texmap !=undefined ) then SetMap  Mat.texmap  HMtl.mtlDiffuse )
			)
		
					
		return Mat		
		)
	
	
	--转换程序A--一切参数以材质库参数为准，只抽取原材质球的贴图放到相应的的位置	
	--传入参数：原始材质，目标材质
	
	
	fn MatA_To_MatB Mtl_Org Mtl_Tar=
		(
		if (superclassof Mtl_Org)!=material and (superclassof Mtl_Tar)!=material then return #(Mtl_Org,Mtl_Tar)	--如果MatA与MatB不是材质类型则返回
			
		--MatOrg_params =if Mtl_Org!=undefined then getPropNames(classof Mtl_Org)	--原始材质球的属性
		--MatTar_params = if Mtl_Tar !=undefined then getPropNames(classof Mtl_Tar)	--目标材质球的属性
		
		orgi_Maps = Get_Map Mtl_Org		--getmaps 提取原始材质的贴图信息
	
		--对目标材质Mtl_Tar的通道进行赋材质操作
		Mtl_Tar2 = copy Mtl_Tar		
		Mtl_Tar2 = SetChannelMap Mtl_Tar orgi_Maps		--对Mtl_Tar进行贴图赋值
		--获取Mtl_Org的颜色信息
		Set_Mat_Color orgi_Maps (Get_Mat_Color Mtl_Org) Mtl_Tar2 	--对Mtl_Tar进行颜色赋值
		--对目标材质进行必要的颜色设置
		if Mtl_Tar2==undefined then return messagebox "未成功生成材质！"
		return Mtl_Tar2
			
		)--方法结束	
	--refs.dependents <MAXWrapper_object>  --返回一个与其相关联的物体的Name 类数组	
		
--从所选择的物体里抽取材质，然后查找所有使用到这个材质的物体，以数组的形式返回这些物体
fn GetObjsFromSelect  = 
(
	local Mtls = #()	--所选物体的材质名集合	
	local resultObjs=undefined
--判断选择的物体是否只有一个材质
	Objs = selection as Array
	Mtls = for obj in Objs where obj.material != undefined  collect obj.material.name
	
	if Mtls.count>0 then Mtls = RemoveTheSame Mtls
	if Mtls.count>1 then messagebox "所先物体有多个材质球，请确认！"
	else if Mtls.count==1 and SceneMaterials[Mtls[1]]!=undefined then 
		
	( matname = Mtls[1]
	  mat =SceneMaterials[matname] 
	  objs =refs.dependents mat 
	  resultObjs = for obj in objs where superclassof obj == GeometryClass collect obj
	) 	--从材质球获取与之相关联物体的数组
		
	if (resultObjs !=undefined and resultObjs.count>0) then return resultObjs
--如果有多个材质，提示
--如果只有一个材质，遍历物体，将它们的材质指定为MatTemp	
)
--------------------------------------------------------------------------------
--获取选择物体的材质，如果有多个材质，提示
fn GetMatFromSelect  = 
(local objs = selection as array
 local mats = for obj in objs where (obj.material!=undefined ) collect obj.material
 
mats[1]

  
)
--------------------------------------------------------------------------------
--设置材质 
--MatTemp材质
fn Set_Mat MatTemp =
(
	matTar = MatTemp
	matTar.name = matTar.name+"_a"+num as string
	global objs = if (GetObjsFromSelect() !=undefined )do GetObjsFromSelect() 	--获取与选择物体同材质的所有obj物体
	--if objs!=undefined do print objs
		
	local mtl = if ($ ==undefined )then messagebox "请选择物体" else  (GetMatFromSelect())
	 
		
	--$.material = (MatA_To_MatB mtl matTar)
	MatTemp2 = MatA_To_MatB mtl matTar
	for obj in objs do  (obj.material=MatTemp2)
	num+=1		
)

--与上面的Set_Mat结合，这里是以名称为源然后从材质库里找到其对应的材质，将这个材质作为参数传给Set_Mat 方法
--MatName 准备指定的材质的材质类型
fn SetMat_FromName MatName = 
(
	Mat = copy  currentMaterialLibrary[MatName]
)

--------------------------------------------------------------------------------


rollout hyq2 "SetMaterial" width:161 height:117
(
	GroupBox grp3 "Mat" pos:[4,11] width:149 height:90
	materialButton btn9 "一键给材质" pos:[11,31] width:85 height:17
	
	button btn17 "将材质导入编辑器/下一屏" pos:[8,76] width:139 height:19
		
		----------------------------------------------------------------------------
		--num=num+1	--后缀数加1	
		
		
	on btn9 picked MatTemp do
	(
		
		Set_Mat MatTemp	--调用Set_Mat方法
					
			
	)
	on btn17 pressed do
	(
	if MatIndex>AllMats.count then MatIndex=1	--如果将所有的材质都导入一遍之后再按此按扭，将重新导入一次
	LoadNextMat()
		
	)
)
	

try(closeRolloutFloater Hyq_Mtl);catch()
Hyq_Mtl = newRolloutFloater "一键给材质" 170 150
--addRollout hyq1 Hyq_Mtl
addRollout hyq2 Hyq_Mtl
