--Last Edited 10/12/21 by SaturnSpades
function onCreate()
	--Create Background sprites
	makeLuaSprite('bg', 'bg', -1200, -650);
	setLuaSpriteScrollFactor('bg', 0.9);

	makeLuaSprite('Energywall', 'Energywall', 1200, -200);

	makeLuaSprite('Spawnhole_Ground_BACK', 'Spawnhole_Ground_BACK', 80, 820);

	makeLuaSprite('Spawnhole_Ground_COVER', 'Spawnhole_Ground_COVER', 30, 845);
	
	makeLuaSprite('exback', 'exback', -650, -200);

	makeLuaSprite('exbackcover', 'exbackcover', -93, 870);
	--setLuaSpriteScrollFactor('exback', 0.9, 0.9);
	--scaleLuaSprite('expurgationback', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		--Low Quality mode not yet implemented
	end

	addLuaSprite('bg', false);
	addLuaSprite('Energywall', false);
	addLuaSprite('exback', false);
	addLuaSprite('exbackcover', true);
	addLuaSprite('Spawnhole_Ground_BACK', false);
	addLuaSprite('Spawnhole_Ground_COVER', true);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end