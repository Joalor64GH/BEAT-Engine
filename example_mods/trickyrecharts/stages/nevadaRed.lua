function onCreate()
	makeLuaSprite('island', 'island_angry', -3400, -800);
	setObjectScale('island', 2, 2);
	addLuaSprite('island', false);

	makeAnimatedLuaSprite('Hank', 'Hank', 700, 410)
    addAnimationByPrefix('Hank', 'Hank', 'Hank', 24, true)
    addLuaSprite('Hank', false)
    objectPlayAnimation('Hank', 'Hank')
end