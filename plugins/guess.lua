if (tonumber(s[5]) and tonumber(s[6])) then
        min = s[5]
        max = s[6]
        msg("Guess the number between "..min.." and ".. max)
        math.randomseed(os.time())
        if (max > min) then 
            nb = math.random(min,max)
        end
elseif (tonumber(s[5]) and nb) then
        guess = tonumber(s[5])
        if (guess < nb) then
            msg("Bigger")
        elseif (guess > nb) then
            msg("Smaller")
        else
            msg("Congrats ! The number was ".. nb)
        end
else
    msg("Error...")
end
