local host = "chat.freenode.net"
local port = 6667
local socket = require("socket")
local tcp = assert(socket.tcp())
local botname = "Brice_De_Nice"
local ident = "Bottos"
local gecos = "Brice, le roi de la glisse !"
local channel = "##aixinfo"

function explode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end

function comparer_debut(chaine,chaine_comparer)
	if(string.lower(chaine) == string.lower(chaine_comparer)) then
		return true
	else
		return false

	end

end








function msg(s)
    if (s) then
        tcp:send("PRIVMSG " .. channel .." :".. s .." \r\n " )
    end
end
function file_exists(name)
       local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

tcp:connect(host, port);

tcp:send("NICK " .. botname .. " \r\n")
tcp:send("USER " .. ident .. " * 8 :".. gecos .." \r\n")

while true do
    s, status, partial = tcp:receive()
    --print(s or partial)
    if status == "closed" then break end
    s = explode(s," ")
    --if s[4] then print(s[4].." est le 4") end 
    if (s[1] == "PING") then
        tcp:send("PONG "..table.concat(s," ",2).."\r\n")
    elseif ((s[2]=="376") or (s[2]=="422")) then
        tcp:send("JOIN " .. channel .. " \r\n")
    elseif (s[4]) then
        if ((string.match(s[4],"!"))) and file_exists("plugins/"..string.sub(s[4],3)..".lua") then
            print("Opening script...")
            --print(s)
            dofile("plugins/"..string.sub(s[4],3)..".lua")
        elseif ((string.lower(s[4]) == ":bonjour") or 
                (string.lower(s[4]) == ":salut") or 
                (string.lower(s[4]) == ":plop") or
                (string.lower(s[4]) == ":yo" )) then

            msg("Salut, ca fart ?")

	elseif comparer_debut(":qui",s[4]) then
		msg("Je suis Brice, Brice de Nice.. Mais appelle moi Brice si tu veux !")
        end
    end
end

tcp:close()
    
