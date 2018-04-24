<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        Application["ROOTURL"] = "stdgw";
	    Application["APP_NAME"] = "STDGW HR";
	    //date Type 0:Korea 1:Vietnam 
	    Application["Lang"] = "1"  ;
	    Application["SYSIMGPATH"] = "/images/sysImages" 	;
	    Application["SMTPSERVER"] = "mail.vinagenuwin.com" ;
    }
    
    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
        
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new Session is started
        //Session.Timeout = 120;
	    Session["Debug"] = "TRUE";
        Session["DebugLog"] = "FALSE";
	    Session["Lang"] = Application["Lang"];
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a Session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If Session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        Response.Redirect("Login.aspx?ermsg=Your session timeout. Please login again to contitnue.", true);

    }
       
</script>
