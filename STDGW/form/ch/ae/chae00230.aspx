<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
    <style type="text/css">
        a:link {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:visited {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:active {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:hover {color:#326da7;text-decoration:none;font-weight:bold}
	    .normals{font-family:Tahoma;font-size:11px;color:#3333ff;font-weight:normal;}
    </style>
  </head>
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 
 <script>
    var flag = '01';
    //--01:Employees' information
    //--02:Recruitment
    //--03:Employees' salary
    function BodyInit()
    {
        txtUser_PK.text="<%=Session("USER_PK") %>";  
        //alert(txtUser_PK.text);      
        OnInit();
    }
    function OnInit()
    {
        txtNewsPK.text='01';
        txtNewsQuantity.text = "6";
        dsoNews.Call("SELECT");
    }
    function BindGrid(gridname,typename){
        var i;
        var strHTML='<table border="0" cellpadding="0" cellspacing="0" width="100%">';
            for(i=1;i<grdNews.rows;i++)
            {
                //alert(i);alert(ttRecord);
                if(i%2==0)
                    strHTML += "<tr style='height:23px'>";
                else 
                    strHTML += "<tr style='height:23px'  bgcolor='f7f6f6'>";
                strHTML += "<td width='32px' align='center' height='24'><img src='../../../system/images/icon_1.gif' border='0'></td>";
                strHTML += "<td align='left' style='padding-left:2px'><a href='#' onclick='OnRedirect(\"chae00230_view.aspx?tp="+typename+"&pk=" + grdNews.GetGridData(i,1) + '")\'>' + grdNews.GetGridData(i,5) +"</a>"+ grdNews.GetGridData(i,3) + "</td>";
                strHTML += "<td style='width:151px' align='center' class='normals'>" + grdNews.GetGridData(i,6) + "</td>";
                strHTML += "<td style='width:101px' align='center' class='normals'>" + grdNews.GetGridData(i,4) + "</td>";
                strHTML += "</tr>";
            }
         strHTML += "</table>";
         var obj = document.getElementById(gridname);
         obj.innerHTML = strHTML;
    }
    function OnRedirect(page)
    {
        var lc = location.href;
        var arr = lc.split("/");
        lc = "";
        for(var x=0; x<arr.length-1; x++){
            lc += arr[x] + "/";
        }
        location.href = lc + page;
    }
    function OnSubmit(){
        
    }
    function OnDataReceive(obj)
    {
       if(obj.id == "dsoNews")
       {
            if(flag=='01')
            {
                if (grdNews.rows==1) //khong co thong bao 
                {
                    var tbl= document.all("tblemp");
                    tbl.style.display="none"
                }
                else
                    BindGrid("infor","01");
                txtNewsPK.text='02';
                txtNewsQuantity.text = "6";
                dsoNews.Call("SELECT");
                flag='02'
            }
            else if(flag=='02')
            {
                if (grdNews.rows==1) //khong co thong bao 
                {
                    var tbl= document.all("tblrecruit");
                    tbl.style.display="none"
                }
                else
                    BindGrid("recruit","02");
                txtNewsPK.text='03';
                txtNewsQuantity.text = "6";
                dsoNews.Call("SELECT");
                flag='03'
            }
            else if(flag=='03')
            {
                if (grdNews.rows==1) //khong co thong bao 
                {
                    var tbl= document.all("tblsalary");
                    tbl.style.display="none";
                    
                }
                else
                    BindGrid("salary","03");
                txtNewsPK.text='04';
                txtNewsQuantity.text = "6";
                dsoNews.Call("SELECT");
                flag='04'
            }
            else if(flag=='04')
            {
                if (grdNews.rows==1) //khong co thong bao 
                {
                    var tbl= document.all("tblTime");
                    tbl.style.display="none";
                    
                }
                else
                    BindGrid("Time_Machine","04");
                flag='finish';
            }
       }
    }
    function OnDataError(oData)
    {
    }
</script>
<body>
    <gw:data id="dsoNews" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,7" function="hr_10010023_announcement_idx">  
                <input bind="grdNews"   >  
                    <input bind="txtNewsPK" />
                    <input bind="txtNewsQuantity" />
                    <input bind="txtUser_PK" />
                </input> 
                <output bind="grdNews" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
            <td align="center" style="padding-top:20px;padding-right:0px">
                <table cellpadding="0" cellspacing="0" width="700px" style="border:1px solid;border-color:#333333">
                    <tr>
                        <td align="left" style="padding: 10px 10px 10px 10px;background-color:#ffffff">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0" id="tblemp">
                                <tr>
							        <td colspan="3" valign="top">
								        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
								            <tr>
								                <td style="font-family:Tahoma;font-size:14px;font-weight:normal;padding-left:10px;padding-top:3px" valign="middle"><img src='../../../system/images/sin_btn_more03.gif' border="0" valign="absbottom" /> <span style="color:#326da7">WHAT'S</span> <span style="color:#a9a9a9">EMPLOYEES' INFORMATION</span></td>
								                <td width="36px" valign="bottom"><a href="#" onclick="OnRedirect('chae00230_list.aspx?tp=01');"><img src='../../../system/images/more_btn.gif' border="0" alt="MORE"></a> </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr><td style="height:5px" colspan="2"></td></tr>
								        </table>
								        <div id="infor"></div>
							        </td>
					            </tr>
                            </table>
                            <div style="height:20px"></div>
                            <table cellpadding="0" cellspacing="0" width="100%" border="0" id="tblrecruit">
                                <tr>
							        <td colspan="3" valign="top">
								        <table border="0" cellpadding="0" cellspacing="0" width="100%">
								            <tr>
								                <td style="font-family:Tahoma;font-size:14px;font-weight:normal;padding-left:10px;padding-top:3px" valign="middle"><img src='../../../system/images/sin_btn_more03.gif' border="0" valign="absbottom" /> <span style="color:#326da7">WHAT'S</span> <span style="color:#a9a9a9">RECRUITMENT</span></td>
								                <td width="36px" valign="bottom"><a href="#" onclick="OnRedirect('chae00230_list.aspx?tp=02');"><img src='../../../system/images/more_btn.gif' border="0" alt="MORE"></a> </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr><td style="height:5px" colspan="2"></td></tr>
								        </table>
								        <div id="recruit"></div>
							        </td>
					            </tr>
                            </table>
                             <div style="height:20px"></div>
                            <table cellpadding="0" cellspacing="0" width="100%" border="0" id="tblTime">
                                <tr>
							        <td colspan="3" valign="top">
								        <table border="0" cellpadding="0" cellspacing="0" width="100%">
								            <tr>
								                <td style="font-family:Tahoma;font-size:14px;font-weight:normal;padding-left:10px;padding-top:3px" valign="middle"><img src='../../../system/images/sin_btn_more03.gif' border="0" valign="absbottom" /> <span style="color:#326da7">WHAT'S</span> <span style="color:#a9a9a9">Time Machine</span></td>
								                <td width="36px" valign="bottom"><a href="#" onclick="OnRedirect('chae00230_list.aspx?tp=04');"><img src='../../../system/images/more_btn.gif' border="0" alt="MORE"></a> </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr><td style="height:5px" colspan="2"></td></tr>
								        </table>
								        <div id="Time_Machine"></div>
							        </td>
					            </tr>
                            </table>
                             <div style="height:20px"></div>
                            <table cellpadding="0" cellspacing="0" width="100%" border="0" id="tblsalary">
                                <tr>
							        <td colspan="3" valign="top">
								        <table border="0" cellpadding="0" cellspacing="0" width="100%">
								            <tr>
								                <td style="font-family:Tahoma;font-size:14px;font-weight:normal;padding-left:10px;padding-top:3px" valign="middle"><img src='../../../system/images/sin_btn_more03.gif' border="0" valign="absbottom" /> <span style="color:#326da7">WHAT'S</span> <span style="color:#a9a9a9">EMPLOYEES' SALARY</span></td>
								                <td width="36px" valign="bottom"><a href="#" onclick="OnRedirect('chae00230_list.aspx?tp=03);"><img src='../../../system/images/more_btn.gif' border="0" alt="MORE"></a> </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr><td style="height:5px" colspan="2"></td></tr>
								        </table>
								        <div id="salary"></div>
							        </td>
					            </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>        
        <tr>
            <td>
                <gw:grid 
                    id="grdNews"
                    header="|||||||"
                    format="0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0" 
                    defaults="||||||" 
                    editcol="0|1|1|1|1|1|1" 
                    widths="0|1500|2000|1200|3000|1000|0"
                    styles="width:100%; display:none" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsQuantity" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtData" styles='width:100%;display:none' />
    <gw:textbox id="txtUser_PK" text="01" styles='width:100%;display:none' />
</body>
</html>
