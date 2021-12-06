function onCreate()
	--Create Background sprites
	makeLuaSprite('bg', 'bg', -1100, -650);
	setLuaSpriteScrollFactor('bg', 0.9);
	scaleLuaSprite('bg', 1.4, 1.4);
	
	makeLuaSprite('island', 'island_notbroken', -1900, -800);
	scaleLuaSprite('island', 1.4, 1.4);
	addLuaSprite('bg', false);
	addLuaSprite('island', false);
end