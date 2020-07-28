serpent = dofile("./lib/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./lib/JSON.lua")
local database = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
Server_SeMo = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_SeMo = function() 
local Create_Info = function(Token,Sudo,UserName)  
local SeMo_Info_Sudo = io.open("sudo.lua", 'w')
SeMo_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
SeMo_Info_Sudo:close()
end  
if not database:get(Server_SeMo.."Token_SeMo") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_SeMo.."Token_SeMo",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_SeMo.."UserName_SeMo") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://TshAkE.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_SeMo.."UserName_SeMo",Json.Info.Username)
database:set(Server_SeMo.."Id_SeMo",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_SeMo_Info()
Create_Info(database:get(Server_SeMo.."Token_SeMo"),database:get(Server_SeMo.."Id_SeMo"),database:get(Server_SeMo.."UserName_SeMo"))   
local RunSeMo = io.open("SeMo", 'w')
RunSeMo:write([[
#!/usr/bin/env bash
cd $HOME/SeMo
token="]]..database:get(Server_SeMo.."Token_SeMo")..[["
rm -fr SeMo.lua
wget "https://raw.githubusercontent.com/TeamSemo/SeMo/master/SeMo.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./SeMo.lua -p PROFILE --bot=$token
done
]])
RunSeMo:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/SeMo
while(true) do
rm -fr ../.telegram-cli
screen -S SeMo -X kill
screen -S SeMo ./SeMo
done
]])
RunTs:close()
end
Files_SeMo_Info()
database:del(Server_SeMo.."Token_SeMo");database:del(Server_SeMo.."Id_SeMo");database:del(Server_SeMo.."UserName_SeMo")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_SeMo()  
var = true
else   
f:close()  
database:del(Server_SeMo.."Token_SeMo");database:del(Server_SeMo.."Id_SeMo");database:del(Server_SeMo.."UserName_SeMo")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
