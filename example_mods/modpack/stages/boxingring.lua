function onCreate()
	-- background shit
	makeLuaSprite('boxingring', 'boxingring', -600, -300);
	setScrollFactor('boxingring', 0.9, 0.9);
	
	makeLuaSprite('invis', 'invis', -650, 600);
	setScrollFactor('invis', 0.9, 0.9);
	scaleObject('invis', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('invis', 'invis', -125, -100);
		setScrollFactor('invis', 0.9, 0.9);
		scaleObject('invis', 1.1, 1.1);
		
		makeLuaSprite('invis', 'invis', 1225, -100);
		setScrollFactor('invis', 0.9, 0.9);
		scaleObject('invis', 1.1, 1.1);
		setProperty('invis.flipX', true); --mirror sprite horizontally

		makeLuaSprite('stagecurtains', 'stagecurtains', -500, -300);
		setScrollFactor('stagecurtains', 1.3, 1.3);
		scaleObject('stagecurtains', 0.9, 0.9);
	end

	addLuaSprite('boxingring', false);
	addLuaSprite('invis', false);
	addLuaSprite('invis', false);
	addLuaSprite('invis', false);
	addLuaSprite('invis', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end