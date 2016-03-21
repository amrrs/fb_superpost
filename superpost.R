#This_code_generates_superpost_alert

require("Rfacebook")
library(httr)
library(mailR)
library(jsonlite)
 
token <- '' #your_fb_token

#intializing dataframes

brand1 <- data.frame()
brand2 <- data.frame()
brand3 <- data.frame()
brand4 <- data.frame()
 
#building_df_with_logo_urls


brands <- as.character(c("brand1",
            "brand2",
            "brand3",
            "brand4"
            
))


logourl <- as.character(c("http://brand1.com/logo.png",
             "http://brand2.com/logo.png",
             "http://brand3.com/logo.png",
	     "http://brand4.com/logo.png"
              
))


logos <- data.frame(brands,logourl) 

logos$brands <- as.character(logos$brands)

logos$logourl <- as.character(logos$logourl)

#downloading_posts 

tryCatch(brand1<- getPage("brand1", token,since = Sys.time()-37809),  error=function(e) { cat('In error handler\n'); print(e); e })
tryCatch(brand2<- getPage("brand2", token, since = Sys.time()-37809),  error=function(e) { cat('In error handler\n'); print(e); e })
tryCatch(brand3<- getPage("brand3", token, since = Sys.time()-37809),  error=function(e) { cat('In error handler\n'); print(e); e })
tryCatch(brand4<- getPage("brand4", token, since = Sys.time()-37809),  error=function(e) { cat('In error handler\n'); print(e); e })
 

#binding_all_df_into_one

final <- rbind(brand1,brand2,brand3,brand4)


#calculating_engagement

final$engagement <- final$likes_count + final$shares_count + final$comments_count

#getting_the_max_engagement_post


pt <- which(final$engagement == max(final$engagement))

message <- final$message[pt]


#extracting_the_picture_associated_with_the_post

grphurl <- paste('https://graph.facebook.com/',final$id[pt],'?fields=full_picture,picture&access_token=',token,sep = '')

doc <- fromJSON(txt=grphurl)

screenshot <- doc$full_picture

logo <- logos$logourl[logos$brands==final$from_name[pt]]   

 
#creating_html_email_body

txt <- paste (
  
  '
             <html>
  
  <body style=" margin:0; padding:0; font-family: "Roboto", sans-serif; 
  background-color:#ffffff;">
  <table width="600" border="0" cellspacing="0" cellpadding="0" align="center" 
  style=" line-height:0; font-size:0;">
  <!--Top Heading Part Start -->
  <tr>
  <td width="600" align="center" valign="top"><table width="600" border="0" 
  cellspacing="0" cellpadding="0" style=" background-color:#f8f8f8;" >
  <tr>
  <td colspan="3" align="center" valign="top" height="15">&nbsp;</td>
  </tr>
  <tr>
  <td width="50" align="center" valign="top">&nbsp;</td>
  <td width="500" align="center" valign="middle" style=" font-size:26px; 
  line-height:30px; color: #000; font-weight:400;">Facebook Superpost Alert</td>
  <td width="50" align="center" valign="top">&nbsp;</td>
  </tr>
  <tr>
  <td colspan="3" align="center" valign="top" height="20">&nbsp;</td>
  </tr>
  </table>
  </td>
  </tr>
  <!--Top Heading Part End -->
  <tr>
  <td width="600" align="center" valign="top"><a href="TBD" target="_blank" 
  title="AUTOCAR"><img src=', screenshot, 
  'alt="AutoCar" style="border:0;" width="600" height="224"/></a></td>
  </tr>
  <tr>
  <td width="600" align="center" valign="top"><table width="600" border="0" 
  cellspacing="0" cellpadding="0">
  <tr>
  <td width="25" align="center" valign="top">&nbsp;</td>
  <td width="550" align="center" valign="middle"><table width="550" border="0" 
  cellspacing="0" cellpadding="0">
  <tr>
  <td width="550" align="center" valign="middle" height="35">&nbsp;</td>
  </tr>
  <tr>
  <td width="550" align="center" valign="middle"><a href="TBD" target="_blank" 
  title=""><img src=',logo,
  ' alt="" style="border:0;" width="236" height="32"/></a></td>
  </tr>
  <tr>
  <td width="550" align="center" valign="middle" height="22">&nbsp;</td>
  </tr>
  <tr>
  <td width="550" align="center" valign="middle" style=" font-size:14px; 
  line-height:21px; color: #898989;  font-weight:400;">',message,
  '</td>
  </tr>
  <tr>
  <td width="550" align="center" valign="middle" height="16">&nbsp;</td>
  </tr>
  <tr>
  <td width="550" align="center" valign="middle"><a href="TBD" title=" " target="_blank" style=" font-size:14px; line-height:20px; text-decoration: underline; color: #3483cc; font-weight:400; ">',final$link[pt],
  '</a></td>
  </tr>
  <tr>
  <td width="600" align="center" valign="top"><table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr><td colspan="9" align="center" valign="middle" height="30"></td></tr>
  <tr>
  
  <td width="16" align="center" valign="top"> </td>
  <td width="125" align="center" valign="middle" style="background-color:#5ec2e8;border:5px solid #fff;border-radius:100%;height:125px;line-height:40px;width:125px"><p style="font-size:30px;line-height:30px;color:#fff;font-weight:bold;margin:0px">', final$likes_count[pt],  
  '</p> <p style="font-size:12px;line-height:23px;margin:0px;font-weight:bold;font-style:italic;color:#fff">Likes</p></td>
  <td width="16" align="center" valign="top"> </td>
  <td width="125" align="center" valign="middle" style="background-color:#2eb06a;border:5px solid #fff;border-radius:100%;height:125px;line-height:40px;width:125px"><p style="font-size:30px;line-height:30px;color:#fff;font-weight:bold;margin:0px">', final$shares_count[pt], 
  '</p> <p style="font-size:12px;line-height:23px;margin:0px;font-weight:bold;font-style:italic;color:#fff">Shares</p></td>
  <td width="16" align="center" valign="top"> </td>
  <td width="125" align="center" valign="middle" style="background-color:#5ec2e8;border:5px solid #fff;border-radius:100%;height:125px;line-height:40px;width:125px"><p style="font-size:30px;line-height:30px;color:#fff;font-weight:bold;margin:0px">', final$comments_count[pt],  
  '</p> <p style="font-size:12px;line-height:23px;margin:0px;font-weight:bold;font-style:italic;color:#fff">Comments</p></td>
  </tr>
  <tr><td colspan="9" align="center" valign="middle" height="30"></td></tr>
  </table>
  </td>
  </tr>
  </table>
  
  </body>
  </html>'
  
  
)


#sending_the_email

send.mail(from = "My Name <myname@gmail.com>",
          to = c("Recipient 1 <recipient1@gmail.com>", "Recipient 2<recipient2@gmail.com>" ),
          subject = "Facebook Superpost Alert.#Test",
          body = txt, 
          smtp = list(host.name = "smtp.gmail.com", port = 465,
                      ssl=TRUE, user.name = "abc@gmail.com",
                      passwd = "xxxxxx"),
          authenticate = TRUE,
          send = TRUE,
          html= TRUE)

