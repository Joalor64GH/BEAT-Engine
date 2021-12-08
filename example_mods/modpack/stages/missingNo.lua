function onCreate()
	makeAnimatedLuaSprite('bg', 'missingno/BG_Assets', -730, -240)
	addAnimationByPrefix('bg', 'idle', 'Bg Sky', 24, true)
	addLuaSprite('bg', false)
	scaleObject('bg', 6, 6)
	setProperty('bg.antialiasing', false)
	objectPlayAnimation('bg', 'idle', true)
	setScrollFactor('bg', 0.9, 0.9)

	makeAnimatedLuaSprite('sea', 'missingno/BG_Assets', -720, -240)
	addAnimationByPrefix('sea', 'idle', 'Bg Ocean', 24, true)
	addLuaSprite('sea', false)
	scaleObject('sea', 6, 6)
	setProperty('sea.antialiasing', false)
	objectPlayAnimation('sea', 'idle', true)
	setScrollFactor('sea', 0.8, 0.8)

	makeAnimatedLuaSprite('ground', 'missingno/BG_Assets', -730, -240)
	addAnimationByPrefix('ground', 'idle', 'Bg Wave', 24, true)
	addLuaSprite('ground', false)
	scaleObject('ground', 6, 6)
	setProperty('ground.antialiasing', false)
	objectPlayAnimation('ground', 'idle', true)
	setScrollFactor('ground', 1, 1)
end

function onStepHit()
	if curStep == 210 then
		triggerEvent('Play Animation', 'enter', '')
		setProperty('dad.visible', true)
	end

	if curStep == 256 then
		setProperty('defaultCamZoom', 0.9)
		doTweenZoom('z', 'camGame', 0.9, 0.6, 'quadInOut')
	end
end

function onCreatePost()
	setProperty('gf.visible', false)
	setProperty('dad.visible', false)
end