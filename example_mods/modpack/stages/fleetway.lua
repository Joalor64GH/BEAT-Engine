
function onCreate()
    setProperty('gf.visible', false);
    setScrollFactor('dad', 1.1, 1);
    setScrollFactor('boyfriend', 1.1, 1);

    makeAnimatedLuaSprite('wall', 'fleetway/Wall', -2379.05, -1211.1);
    addAnimationByPrefix('wall', 'a', 'Wall instance 1');
    setScrollFactor('wall', 1.1, 1.1);
    objectPlayAnimation('wall', 'a');
    addLuaSprite('wall', false);

    makeAnimatedLuaSprite('floor', 'fleetway/Floor', -2349, 921.25);
    addAnimationByPrefix('floor', 'a', 'floor blue');
    addAnimationByPrefix('floor', 'b', 'floor yellow');
    objectPlayAnimation('floor', 'a', true);
    setScrollFactor('floor', 1.1, 1);
    addLuaSprite('floor', false);

    makeAnimatedLuaSprite('fleetwaybgshit', 'fleetway/FleetwayBGshit', -2629.05, -1344.05);
    addAnimationByPrefix('fleetwaybgshit', 'a', 'BGblue');
    addAnimationByPrefix('fleetwaybgshit', 'b', 'BGyellow');
    setScrollFactor('fleetwaybgshit', 1.1, 1);
    objectPlayAnimation('fleetwaybgshit', 'a', true);
    addLuaSprite('fleetwaybgshit', false);

    makeAnimatedLuaSprite('emeraldBeam', 'fleetway/Emerald Beam', 0, -1376.95 - 200);
    addAnimationByPrefix('emeraldBeam', 'a', 'Emerald Beam instance 1', 24, true);
    objectPlayAnimation('emeraldBeam', 'a');
    setScrollFactor('emeraldBeam', 1.1, 1);
    if not seenCutscene then
        addLuaSprite('emeraldBeam', false);
    end

    makeAnimatedLuaSprite('emeraldbeamyellow', 'fleetway/Emerald Beam Charged', -300, -1376.95 - 200);
    addAnimationByPrefix('emeraldbeamyellow', 'a', 'Emerald Beam Charged instance 1', 24, true);
    objectPlayAnimation('emeraldbeamyellow', 'a');
    setScrollFactor('emeraldbeamyellow', 1.1, 1);
    addLuaSprite('emeraldbeamyellow', false);
    setProperty('emeraldbeamyellow.visible', false);

    makeAnimatedLuaSprite('emeralds', 'fleetway/Emeralds', 326.6, -191.75);
    addAnimationByPrefix('emeralds', 'a', 'TheEmeralds instance 1', 24, true);
    objectPlayAnimation('emeralds', 'a');
    setScrollFactor('emeralds', 1.1, 1);
    addLuaSprite('emeralds', false);

    makeAnimatedLuaSprite('thechamber', 'fleetway/The Chamber', -225.05, 463.9);
    addAnimationByPrefix('thechamber', 'a', 'Chamber Sonic Fall', 24, false);
    setScrollFactor('thechamber', 1.1, 1);
    setProperty('thechamber.active', 'false');
    addLuaSprite('thechamber', true);
    if seenCutscene then
        objectPlayAnimation('thechamber', 'a');
        setProperty('thechamber.animation.frameIndex', getProperty('thechamber.animation.frames'));
    end

    makeAnimatedLuaSprite('pebles', 'fleetway/pebles', -562.15 + 100, 1043.3);
    addAnimationByPrefix('pebles', 'a', 'pebles instance 1');
    addAnimationByPrefix('pebles', 'b', 'pebles instance 2');
    if seenCutscene then
        objectPlayAnimation('pebles', 'b');
    else
        objectPlayAnimation('pebles', 'a');
    end
    setScrollFactor('pebles', 1.1, 1);
    addLuaSprite('pebles', false);

    makeAnimatedLuaSprite('porker', 'fleetway/Porker Lewis', 2880.15, -762.8);
    addAnimationByPrefix('porker', 'porkerbop', 'Porker FG');
    setScrollFactor('porker', 1.4, 1);
    addLuaSprite('porker', true);
end

function onBeatHit()
    objectPlayAnimation('porker', 'porkerbop');
end

function onCountdownTick()
    onBeatHit();
end