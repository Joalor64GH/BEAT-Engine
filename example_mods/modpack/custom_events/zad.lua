function onCreate() -- Add The Flicker

	makeAnimatedLuaSprite('sad', 'sad', -90, -50)
	
	-- Properties
	setScrollFactor('sad', 0, 0)
	scaleObject('sad', 1.5, 1.5)
	
	-- Animations
	addAnimationByPrefix('sad', 'zad', 'zad', 24, false)
	
end

function onEvent(name, value1, value2)
	if name == 'zad' then
	playSound('BOOM')
	runTimer('zaad', 0.9, 1)
	addLuaSprite('sad', true)
	objectPlayAnimation('zad', true)
	end
end
	
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'zaad' then
	setProperty('sad.visible', false)
	end
end