function onCreate()
	makeLuaSprite('bg', 'bg', -1200, -650);
	setLuaSpriteScrollFactor('bg', 0.9);
	makeLuaSprite('Spawnhole_Ground_BACK', 'trickyimages/Spawnhole_Ground_BACK', 80, 820);
	makeLuaSprite('Spawnhole_Ground_COVER', 'trickyimages/Spawnhole_Ground_COVER', 30, 845);
	makeLuaSprite('exback', 'trickyimages/exback', -650, -200);
	makeLuaSprite('exbackcover', 'trickyimages/exbackcover', -93, 870);

	addLuaSprite('bg', false);
	addLuaSprite('exback', false);
	addLuaSprite('exbackcover', true);
	addLuaSprite('Spawnhole_Ground_BACK', false);
	addLuaSprite('Spawnhole_Ground_COVER', true);
end