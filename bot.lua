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

function comparer_debut(a_comparer,chaine_user,chaine_print) -- compare the first word of user --
	if(chaine_user) then
		if(string.lower(a_comparer) == string.lower(chaine_user)) then
			msg(chaine_print)
		end
	end
end


function bot_answer(chaine_user) -- ask to the bot answer if one of the word in sentence is understand by him --
	comparer_debut(":bonjour",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":salut",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":yo",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":plop",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":bonsoir",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":coucou",chaine_user[4],"Salut, ça fart ?")
	comparer_debut(":salut !",chaine_user[4],"Salut, ça fart ?")
	-- others --
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
        else bot_answer(s)
        end
    end
end

tcp:close()
    
