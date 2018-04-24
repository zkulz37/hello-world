<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
    <style type="text/css">
        a:link {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:visited {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:active {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:hover {color:#326da7;text-decoration:none;font-weight:bold}
	    .normals{font-family:Tahoma;font-size:11px;color:#8e8e8e;font-weight:normal;}
    </style>
</head>
<% ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
    var flag = 'announ';
    function BodyInit(){
        System.Translate(document); 
        OnInit();
    }
    function OnInit(){
        txtNewsPK.text='announ';
        txtNewsQuantity.text = "6";
        dsoNews.Call("SELECT");
    }
    function BindGrid(gridname,typename){
        var i;
        var strHTML='<table border="0" cellpadding="0" cellspacing="0" width="100%">';
            for(i=1;i<grdNews.rows;i++){
                //alert(i);alert(ttRecord);
                if(i%2==0)
                    strHTML += "<tr style='height:23px'>";
                else 
                    strHTML += "<tr style='height:23px'  bgcolor='f7f6f6'>";
                strHTML += "<td width='32px' align='center' height='24'><img src='icon_1.gif' border='0'></td>";
                strHTML += "<td align='left' style='padding-left:2px'><a href='#' onclick='OnRedirect(\"agas0020_view.aspx?tp="+typename+"&pk=" + grdNews.GetGridData(i,1) + '")\'>' + grdNews.GetGridData(i,5) +"</a>&nbsp;"+ grdNews.GetGridData(i,3) + "</td>";
                strHTML += "<td style='width:151px' align='center' class='normals'>" + grdNews.GetGridData(i,6) + "</td>";
                strHTML += "<td style='width:101px' align='center' class='normals'>" + grdNews.GetGridData(i,4) + "</td>";
                strHTML += "</tr>";
            }
         strHTML += "</table>";
         var obj = document.getElementById(gridname);
         obj.innerHTML = strHTML;
    }
    function OnRedirect(page){
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
    function OnDataReceive(obj){
       if(obj.id == "dsoNews"){
            if(flag=='announ'){
                BindGrid("grid","announ");
                txtNewsPK.text='board';
                txtNewsQuantity.text = "6";
                dsoNews.Call("SELECT");
                flag='board'
            }else if(flag=='board'){
                BindGrid("board","board");
                flag='finish'
            }
       }
    }
    function OnDataError(oData){
    }
</script>

<body>
    <gw:data id="dsoNews" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,7" function="sp_sel_agas0020_index">  
                <input bind="grdStudent"   >  
                    <input bind="txtNewsPK" />
                    <input bind="txtNewsQuantity" />
                </input> 
                <output bind="grdNews" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
            <td align="center" style="padding-top: 20px; padding-right: 0px">
                <table cellpadding="0" cellspacing="0" width="700px" style="border: 1px solid; border-color: #333333">
                    <tr>
                        <td align="left" style="padding: 10px 10px 10px 10px; background-color: #ffffff">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td colspan="3" valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-family: Tahoma; font-size: 14px; font-weight: normal; padding-left: 10px;
                                                    padding-top: 3px" valign="middle">
                                                    <img src="sin_btn_more03.gif" border="0" valign="absbottom" />
                                                    <span style="color: #326da7">WHAT'S</span> <span style="color: #a9a9a9">ANNOUNCEMENT</span></td>
                                                <td width="36px" valign="bottom">
                                                    <a href="#" onclick="OnRedirect('agas0020_list.aspx?tp=announ');">
                                                        <img src="more_btn.gif" border="0" alt="MORE"></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 1px solid; background-color: #0363b2" valign="absbottom" colspan="2">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px" colspan="2">
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="grid">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div style="height: 20px">
                            </div>
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td colspan="3" valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-family: Tahoma; font-size: 14px; font-weight: normal; padding-left: 10px;
                                                    padding-top: 3px" valign="middle">
                                                    <img src="sin_btn_more03.gif" border="0" valign="absbottom" />
                                                    <span style="color: #326da7">WHAT'S</span> <span style="color: #a9a9a9">BOARD</span></td>
                                                <td width="36px" valign="bottom">
                                                    <a href="#" onclick="OnRedirect('agas0020_list.aspx?tp=board');">
                                                        <img src="more_btn.gif" border="0" alt="MORE"></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 1px solid; background-color: #0363b2" valign="absbottom" colspan="2">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 5px" colspan="2">
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="board">
                                        </div>
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
                <gw:grid id="grdNews" header="|||||||" format="0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0"
                    defaults="||||||" editcol="0|1|1|1|1|1|1" widths="0|1500|2000|1200|3000|1000|0"
                    styles="width:100%; height:100%;display:none" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsQuantity" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtData" styles='width:100%;display:none' />
</body>
</html>
