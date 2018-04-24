<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Page</title>

    <script language="javascript" type="text/javascript">
    var s = new String();
    
    function BodyInit()
    {
      
    }
    function OnLoadFrame()
    {
        var rowPro = grdProcedure.rows - 1;
        while(rowPro > 0)
        {
            grdProcedure.RemoveRowAt(rowPro);
            rowPro = grdProcedure.rows - 1;
        }
        
        var rowPR = grdPopup.rows - 1;
        while(rowPR > 0)
        {
            grdPopup.RemoveRowAt(rowPR);
            rowPR = grdPopup.rows - 1;
        }
        
        if(txtFormURL.text != "")
            window.frames["ifrFormSource"].document.location.href = "../../../system/ViewSource.aspx?file_name=../" + txtFormURL.text //form/sys/auth/wsyau00001.aspx";    
        else
            alert("You must input Form URL")
    }
    
    function OnGetFormURL()
    {
        s = window.frames["ifrFormSource"].document.body.innerHTML;
        s = s.replace(" ", "");
        
        var aFunc = new Array();
        var aProc = new Array();
        var aPopup = new Array();
        var aReport = new Array();
        var temp = new String();
        aFunc = s.split('function="');
        aFunc1 = s.split('function= "');
        aFunc2 = s.split('function ="');
        aFunc3 = s.split('function = "');
        aProc = s.split('procedure="');
        aProc1 = s.split('procedure= "');
        aProc2 = s.split('procedure ="');
        aProc3 = s.split('procedure = "');
        aReport = s.split('/reports');
        aReport1 = s.split('/reports');
        aPopup = s.split('/form');
          
          for(var i=1 ; i < aFunc.length ; i++ ){
            temp = aFunc[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"SELECT");
          }
          
          for(var i=1 ; i < aFunc1.length ; i++ ){
            temp = aFunc1[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"SELECT");
          }
          
          for(var i=1 ; i < aFunc2.length ; i++ ){
            temp = aFunc2[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"SELECT");
          }
          
          for(var i=1 ; i < aFunc3.length ; i++ ){
            temp = aFunc3[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"SELECT");
          }
          
          for(var i=1 ; i < aProc.length ; i++ ){
            temp = aProc[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"UPDATE");
          }
          
          for(var i=1 ; i < aProc1.length ; i++ ){
            temp = aProc1[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"UPDATE");
          }
          
          for(var i=1 ; i < aProc2.length ; i++ ){
            temp = aProc2[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"UPDATE");
          }
          
          for(var i=1 ; i < aProc3.length ; i++ ){
            temp = aProc3[i];
            lastIdx = temp.indexOf('"');
            temp = temp.substr(0,lastIdx);
            grdProcedure.AddRow();
            grdProcedure.SetGridText(grdProcedure.rows-1,0,temp);
            grdProcedure.SetGridText(grdProcedure.rows-1,1,"UPDATE");
          }
          
          for(var i=0 ; i < aPopup.length ; i++ ){
            temp = aPopup[i+1];
            if(temp != null)
            {
                if(temp.indexOf(".aspx") != -1)
                {
                    temp = "/form"+temp.substr(0, temp.indexOf(".aspx")) + ".aspx";
                    grdPopup.AddRow();
                    grdPopup.SetGridText(grdPopup.rows-1,0,temp);
                }
            }
          }
          
          for(var i=0 ; i < aReport.length ; i++ ){
            temp = aReport[i+1];
            if(temp != null)
            {
                if(temp.indexOf(".aspx") != -1)
                {
                    temp = "/reports"+temp.substr(0, temp.indexOf(".aspx")) + ".aspx";
                    grdPopup.AddRow();
                    grdPopup.SetGridText(grdPopup.rows-1,0,temp);
                }
            }
          }
          
          for(var i=0 ; i < aReport1.length ; i++ ){
            temp = aReport1[i+1];
            if(temp != null)
            {
                if(temp.indexOf(".xls") != -1)
                {
                    temp = "/reports"+temp.substr(0, temp.indexOf(".xls")) + ".xls";
                    grdPopup.AddRow();
                    grdPopup.SetGridText(grdPopup.rows-1,0,temp);
                }
            }
          }
                
        }
		
	function OnShowObjects()
	{
		//alert("");
		var fpath = System.RootURL + "/form/sys/ab/FormDependence_GetFormObject.aspx";
		var object = System.OpenModal(fpath , 600 , 500 , 'titleb:0;resizable:no;status:no;dialogWidth:50;dialogHeight:31;dialogLeft:5;dialogTop:30;edge:sunken;scroll:no;unadorned:yes;help:no'); 
		if ( object != null ) 
		{
			if (object[0] != 0)
			{
				txtFormURL.SetDataText(object[0]);
				OnLoadFrame();
			}

		}
	}
</script>

</head>
<body>
    
    <table width="100%" border=0>
        <tr>
            <td>
                <table width="100%">
                    <tr>
						<td width="10%"  align="right"><a title="Click here to get form url" onclick="OnShowObjects()" href="#tips" ><b>Form URL&nbsp;</b></a></td>
						<td width="30%">
                            <gw:textbox id="txtFormURL" styles="width:100%" onEnterkey="OnLoadFrame()" />
                        </td>
                        <td width="1%">
                            <gw:imgbtn id="btnGetFormURL" img="popup" alt="Info File" onclick="OnLoadFrame()" />
                        </td>                           
                    </tr>
                </table>
            </td>            
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td width="30%">
                            <gw:grid id="grdPopup" header="PopUp/Report" format="0" aligns="0" defaults="" editcol="0"
                                widths="0" styles="width:100%; height:200" sorting="T" />
                        </td>
                        <td width="70%">
                            <gw:grid id="grdProcedure" header="Procedure|Type" format="0|0" aligns="0|0" defaults="|" editcol="0|0"
                                widths="7000|2000" styles="width:100%; height:200" sorting="T" />
                        </td>        
                    </tr>
                </table>
            </td>            
        </tr>
        <tr>
            <td colspan="4">
                <iframe onload="OnGetFormURL()" id="ifrFormSource" width="100%" height="250px" />
            </td>
        </tr>
    </table>
</body>
</html>
