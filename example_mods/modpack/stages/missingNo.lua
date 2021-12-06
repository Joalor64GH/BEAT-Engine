function onCreate()
	--Create Background sprites
	makeLuaSprite('bg', 'missingno/bg', -1100, -650);
	setLuaSpriteScrollFactor('bg', 0.9);
	scaleLuaSprite('bg', 1.4, 1.4);
	
	makeLuaSprite('island', 'missingno/ground', -1900, -800);
	scaleLuaSprite('island', 1.4, 1.4);
	addLuaSprite('bg', false);
	addLuaSprite('island', false);
end