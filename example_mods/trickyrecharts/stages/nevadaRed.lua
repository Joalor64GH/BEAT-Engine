--Last Edited 10/12/21 by SaturnSpades
function onCreate()
	--Create Background sprites
	makeLuaSprite('red', '', -1200, -650);
	luaSpriteMakeGraphic('red', 4000, 2000, '290c0c')
	setLuaSpriteScrollFactor('red', 0.9);
	
	makeLuaSprite('island_but_red', 'island_but_red', -3400, -800);
	scaleLuaSprite('island_but_red', 2, 2);

	addLuaSprite('red', false);
	addLuaSprite('island_but_red', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end