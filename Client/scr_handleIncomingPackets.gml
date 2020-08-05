/// @param buffer
/// @param ...
var buffer = argument[0];
var msgId = buffer_read(buffer, buffer_u8);// find the tag

switch(msgId)
{
    case 1: // latency response
        var time = buffer_read(buffer, buffer_u32);// read in the time from the server
        global.latency = current_time - time;// update our latency
    break;
    
    case 2: // registration response
        var response = buffer_read(buffer, buffer_u8);
        
        switch(response)
        {
            case 0://failure
                scr_showNotification("Registration failed! Username already exists!");
            break;
            
            case 1://success
                global.playerX = buffer_read(buffer, buffer_u32);
                global.playerY = buffer_read(buffer, buffer_u32);
                global.playerRoom = buffer_read(buffer, buffer_u8);
                
                // todo: let's send the player to the correct room
                room_goto(rm_menu);
            break;
        }
    break;
    
    case 3: // login response
        var response = buffer_read(buffer, buffer_u8);
        
        switch(response)
        {
            case 0:// failure
                scr_showNotification("Login failed! Username doesn't exist or password is incorrect!");
            break;
            
            case 1://success
                global.playerX = buffer_read(buffer, buffer_u32);
                global.playerY = buffer_read(buffer, buffer_u32);
                global.playerRoom = buffer_read(buffer, buffer_u8);
                
                // todo: let's send the player to the correct room
                room_goto(rm_menu);
            break;
        }
   