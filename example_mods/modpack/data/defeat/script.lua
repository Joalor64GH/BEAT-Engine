function noteMiss(as,sas,gas,pas) --checks when the player misses
    --debugPrint('mised')
    if getProperty('dad.animation.curAnim.name') ~= 'kill' then --checks if blacks current animation isnt 'kill'
        triggerEvent('Black Kill', 0, 0) --triggers event
    end
end