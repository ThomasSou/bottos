if (tonumber(s[5]) and tonumber(s[6])) then
        min = s[5]
        max = s[6]
        msg("Devinez un nombre entre "..min.." et ".. max)
        math.randomseed(os.time())
        nb = math.random(min,max)
elseif (tonumber(s[5])) then
        guess = tonumber(s[5])
        if (guess < nb) then
            msg("Plus grand")
        elseif (guess > nb) then
            msg("Plus petit")
        else
            msg("Bravo, le nombre etait ".. nb)
        end
else
    msg("C'est pas un nombre wallah")
end