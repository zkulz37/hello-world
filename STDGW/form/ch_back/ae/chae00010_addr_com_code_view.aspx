<!-- #include file="../../../system/lib/form.inc"  -->

  <head>
    <title>genuwin</title>
  </head>
  
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 
 <script>

 var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{    
    grdDetailCode.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document); 
    txtInput.text="<%=Request.querystring("code")%>";
	txtChar5.text="<%=Request.querystring("char5")%>";
	txtInput_CODEGRP.text="<%=Request.querystring("code")%>";
	       
    //OnSearch();        
}
//--------------------------------
function OnSearch()
{  											
    datCodeGrp.Call();
	//datDetailCode.Call("SELECT");
	
}
function OnDataReceive(obj)
{
    
    if (obj.id=="datDetailCode")
    {
        lblRecord.text=grdDetailCode.rows-1 + " record(s).";
        auto_resize_column(grdDetailCode,0,grdDetailCode.cols-1,0);
    }
    else if (obj.id=="datCodeGrp")
    {    		
       if (txtCodeGrp_PK.text=="")
            alert("Can't find code group like this!Please input another.");
       else
       {            
            datDetailCode.Call("SELECT");          
       }
    }    
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------
function OnSelectClick()
{
   var obj=new Array();  
	obj[0]=0;
    if (grdDetailCode.row >= 1)
    {
        obj[1]=grdDetailCode.GetGridData(grdDetailCode.row,3);
		obj[2]=grdDetailCode.GetGridData(grdDetailCode.row,4);
    }
    else
	{
        obj[1]=0;
		obj[2]="";
    }
	window.returnValue = obj; 
	window.close();
}
//------------------------------------------------
function OnCloseClick()
{
   
	var obj=new Array();    
    obj[0]=0;
	obj[1]=0;
	obj[2]="";
	window.returnValue = obj; 
	window.close();
}
 </script>

<body>
<!---------------------------------------------------------->
<gw:data id="datDetailCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  parameter="" function="HR_sel_10010001_detaicode_addr" procedure=""> 
                <input bind="grdDetailCode" >
                    <input bind="txtCodeGrp_PK" />
                    <input bind="txtCompany_pk" /> 
					<input bind="txtChar5" /> 
                    <input bind="lstTemp" /> 
					<input bind="txtInput2" /> 
                </input>
                <output  bind="grdDetailCode" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------->  

<gw:data id="datCodeGrp"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process"  procedure="HR_SP_PRO_CODEGRPPK" > 
                <input> 
                    <input bind="txtFlag" /> 
                    <input bind="txtInput_CODEGRP" /> 
                    <input bind="txtInput_CODEGRP_NM" /> 
                </input> 
                <output >
                    <output bind="txtInput_CODEGRP" />
                    <output bind="txtInput_CODEGRP_NM" />
                    <output bind="txtCodeGrp_PK" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 	

<!------------------------------ MainTable ------------------------>
<table    style='margin-left:10px' cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%">
	<tr style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top">
	    <td>
	        <table border=1 cellpadding="0" cellspacing="0"  style="height:100%" width="100%">
                <tr style="width:100%;height:5%;border:0" valign="middle" cellpadding="0" cellspacing="0">
                    <td style="width:8%;border:0" align="center">ID</td>						
		            <td width="15%" valign="middle" style="border:0"><gw:textbox id="txtInput"  csstype="mandatory" styles='width:95%' onenterkey ="" /></td>
                    	
                     <td style="width:10%;border:0" align="right">search by</td>	
                      <td style="border:0;width:15%;">
					        <gw:list  id="lstTemp" value="1" styles='width:100%' onchange=""> 
							        <data>LIST|1|Code Name|2|Code</data> 
					        </gw:list>
				        </td>					
		            <td width="30%" valign="middle" style="border:0"><gw:textbox id="txtInput2"  csstype="mandatory" styles='width:95%' onenterkey ="OnSearch()" /></td>
		            <td width="15%" align="center" style="border:0"><gw:label img="new" id="lblRecord"  style="font-weight:bold;color:red;font-size:12 "  text="0 record(s)"/></td>
                    <td width="5%" style="border:0" align="right"><td>
		            <td width="5%" style="border:0" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" onclick="OnSearch()" />  <td>                   
		            <td width="7%" style="border:0" align="right"><gw:imgBtn img="select"    alt="Select"     id="ibtnSelect" 	onclick="OnSelectClick()" /></td>
		            <td width="7%"style="border:0" align="right"><gw:imgBtn img="cancel"    alt="Close"     id="ibtnClose" 	onclick="OnCloseClick()" /></td>
	            </tr>
            	<tr style="width:100%;height:95%;border:1" valign=top cellpadding="0" cellspacing="0">
		            <td width="100%" colspan=12 >
				             <gw:grid   
                                        id="grdDetailCode"  
                                        header="_PK|_MasterPK|NO|CODE|NAME|KNAME|FNAME|NUM 1|NUM 2|NUM 3|NUM 4|NUM 5|CHA 1|CHA 2|CHA 3|CHA 4|CHA 5|USE Y/N|REMARK|_company"   
                                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0"  
                                        aligns="1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                        defaults="|||||||||||||||||-1||"  
                                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                        widths="1000|0|700|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0"  
                                        styles="width:100%; height:100%"   
                                        sorting="F" 
										oncelldblclick="OnSelectClick()"
                                        /> 

		            </td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
	   
    <gw:textbox id="txtCodeGrp_PK"  text="" styles="display:none" />    
    <gw:textbox id="txtFlag" styles="display:none" text="1" />	
	<gw:textbox id="txtCompany_pk" styles="display:none" text="ALL"/>
	<gw:textbox id="txtInput_CODEGRP"  styles="display:none" />
    <gw:textbox id="txtInput_CODEGRP_NM"  styles="display:none" />	
	
	<gw:textbox id="txtChar5" styles="display:none" text="ALL"/>	

</body>
</html>
