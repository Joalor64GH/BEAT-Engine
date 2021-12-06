function onCreate()
	makeLuaSprite('island', 'trickyimages/island_angry', -3400, -800);
	setObjectScale('island', 2, 2);
	addLuaSprite('island', false);

	makeAnimatedLuaSprite('Hank', 'trickyimages/Hank', 700, 410)
    addAnimationByPrefix('Hank', 'Hank', 'Hank', 24, true)
    addLuaSprite('Hank', false)
    objectPlayAnimation('Hank', 'Hank')
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    cameraShake('game', 0.01, 0.1)
end