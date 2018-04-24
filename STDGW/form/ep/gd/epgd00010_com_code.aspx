
<!-- #include file="../../../system/lib/form.inc"  -->

  <head>
    <title>genuwin</title>
  </head>
  
 <%ESysLib.SetUser("comm")%>
 
 <script>
var flag=0; //chua co modify thong tin
var bAdd=false;
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    
    txtInput.text="<%=Request.querystring("code")%>";
    OnSearch();    
}

//--------------------------------
function OnSearch()
{
    if (bAdd==false)
        grdDTL.ClearData();
    if (rdoKIND.value==1)
    {
        txtInput_CODEGRP.text=txtInput.text;
        txtInput_CODEGRP_NM.text="";
    }
    else
    {
        txtInput_CODEGRP.text="";
        txtInput_CODEGRP_NM.text=txtInput.text;
    }
    txtCodeGrp_PK.text="";
    txtFlag.text=rdoKIND.value;
    
	datCodeGrp.Call();
	
}

//------------------------------------------------------
function AddOnClick()
{
    if (txtCodeGrp_PK.text!="")
    {
        flag=1;
	    if(txtInput_USEYN.GetData() == 0)
	    {
		    var control = grdDTL.GetGridControl();
		    grdDTL.AddRow();
		    grdDTL.SetCellBgColor(1,2,grdDTL.rows -1 ,2,0xd4d3ff);
		    var row = control.Rows  - 1;
    		
		    grdDTL.SetGridText( row , 1, txtCodeGrp_PK.GetData());
		    grdDTL.GetGridControl().TopRow=row;
		    preparedModify();
        }
	    else
	    {
		    txtInput_USEYN.SetDataText("0");
		    bAdd=true;
		    datCode_DTLs.Call();
	    }
	}
	else
	    alert("Please search a code");
}
//--------------------------------

function preparedModify()
{
	var ipos = 1 ;
	var jpos = 10;
	for (i=1; i<grdDTL.rows; i++)
	{
		if(grdDTL.GetRowStatus(ipos) != 64)
		{
			grdDTL.SetGridText( ipos, 2, jpos  );
			jpos = jpos+10;
		}
		ipos ++;
	}	
	
}
//-----------------------------------
function checkData()
{
	var ctrl 	= grdDTL.GetGridControl();
	var rownum 	= ctrl.Row;
	var rownums 	= ctrl.Rows;
	
	if(rownum > 0 && rownums>1)
	{
	    
	    if(grdDTL.GetRowStatus(ctrl.Row) >= 64)
		{
			ibtnDelete.SetEnable(false);
			ibtnDelete1.SetEnable(true);
		}
		else
		{
			ibtnDelete.SetEnable(true);
			ibtnDelete1.SetEnable(false);
		}
	}
}
//--------------------------------
function checkDefault()
{
    var ctrl	= grdDTL.GetGridControl();
	var row 	= ctrl.Rows;
	
	if(ctrl.Row >=1 && event.col == 3)
	{
		for(i=1; i<row; i++)
		{
			grdDTL.SetGridText( i , 3, "0");
		}
		grdDTL.SetGridText( ctrl.Row , 3, "-1");
	}
}
//--------------------------------
function DeleteOnClick()
{
    if(confirm("Do you want to delete?"))
    {    
        grdDTL.DeleteRow();
        ibtnDelete.SetEnable(false);
		ibtnDelete1.SetEnable(true);
    }
        
}
//--------------------------------------------------------
function UnDeleteOnClick()
{
    if(confirm("Do you want to undelete?"))
    {
        grdDTL.UnDeleteRow();
        ibtnDelete.SetEnable(true);
		ibtnDelete1.SetEnable(false);
    }    
}
//-----------------------------------------------------------
function UpdateOnClick()
{
    if(checkItemLength() && checkDupItems()  && checkNumber()   && checkORD())
	{
	    flag=1;
		datCode_DTLs.Call(); 
	}	
		
}
//------------------------------------------------------
function checkORD()
{
	var ctrl	= grdDTL.GetGridControl();
	var row 	= ctrl.Rows;
	var cnt = 0;
	if(ctrl.Row >1 )
	{
		for(i=1; i<row; i++)
		{
			var data = grdDTL.GetGridData(i, 2);
			if(isNaN(data))
			{
				alert("Please enter at col " + i + " and " + j + " is number");
				return false;
			}
			if (parseInt(data) < 0)
			{
				alert("Please enter at col " + i + " and " + j + " is number");
				return false;
			}
		}
	}
	return true;
}
//------------------------------------------------------
function checkNumber()
{
	var ctrl 	= grdDTL.GetGridControl();
	var rownum 	= ctrl.Rows;
	
	if(rownum == 1)return false;
	
	var i;
	for(i=1; i<rownum; i++)
	{
	 	for(j=11; j <= 13; j++)
		{
			var ij_num 	= grdDTL.GetGridData(i, j);
			ij_num		= ij_num.toUpperCase();
			if (isNaN(ij_num))
			{
				alert("Please enter is number at col " + i + " and " + j);
				return false;
			}
			if (parseInt(ij_num) < 0)
			{
				alert("Please enter is number > 0 at col " + i + " and " + j);
				return false;
			}
		}	
	}
	return true;
}
//------------------------------------
function checkDupItems()
{
    var ctrl 	= grdDTL.GetGridControl();
    var rownum 	= ctrl.Rows;
    if(rownum == 1)
    {
	    return false;
    }
    var i;
    for(i=1; i<rownum; i++)
    {
      for(j=i+1; j<rownum; j++)
      {
  	    var i_code 	= grdDTL.GetGridData(i, 4);
	    i_code		= i_code.toUpperCase();
	    var j_code 	= grdDTL.GetGridData(j, 4);
	    j_code		= j_code.toUpperCase();
    	
	    if(j_code == i_code)
	    {
		    if(j_code == "" ){	}
		    else
		    {
			    alert("Code already in use, please re-enter at rows " + i + " and " + j);
			    return false;
		    }
	    }
      }	
    }
    return true;
}
//------------------------------------------------------
function checkItemLength()
{
    var ctrl 	= grdDTL.GetGridControl();
    var rownum 	= ctrl.Rows;

    if(rownum == 1)return false;

    var i;
    for(i=1; i<rownum; i++)
    {
	    if(grdDTL.GetGridData(i, 0) != "")
	    {
		    if(grdDTL.GetGridData(i, 2)==""  )
		    {
			    alert("Please enter ORD at row " + i + " ...");
			    return false;
		    }
		    if(grdDTL.GetGridData(i, 4)==""  )
		    {
			    alert("Please enter Code at row " + i + " ...");
			    return false;
		    }
		    else
		    {
			    if(grdDTL.GetGridData(i, 5)=="" )
			    {
				    alert("Please enter Code Name at row " + i + " ...");
				    return false;
			    }
		    }
		    if(grdDTL.GetGridData(i, 4).length > txtCODE_LEN.GetData())
		    {
			    alert("Please enter Code length at row " + i + " less or equal " + txtCODE_LEN.GetData() + " character ...");
			    return false;
		    }
    		
	    }
	    else
	    {
		    if(grdDTL.GetGridData(i, 4)!=""  )
		    {
			    if(grdDTL.GetGridData(i, 5)=="" )
			    {
				    alert("Please enter Code Name at row " + i + " ...");
				    return false;
			    }
			    if(grdDTL.GetGridData(i, 4).length > txtCODE_LEN.GetData())
			    {
				    alert("Please enter Code length at row " + i + " less or equal " + txtCODE_LEN.GetData() + " character ...");
				    return false;
			    }
			    if(grdDTL.GetGridData(i, 2)==""  )
			    {
				    alert("Please enter ORD at row " + i + " ...");
				    return false;
			    }
		    }
	    }
    }
    return true;
}
//--------------------------------

function OnDataReceive(obj)
{
    
    if (obj.id=="datCodeGrp")
    {
       
       if (txtCodeGrp_PK.text=="")
            alert("Can't find code group like this!Please input another.");
       else
       {
            if (rdoKIND.value==1)
               txtInput.text=txtInput_CODEGRP.text;
            else
                txtInput.text=txtInput_CODEGRP_NM.text;
            datCode_DTLs.Call("SELECT");
            
       }
    }    
    else if (obj.id=="datCode_DTLs")
    {
        if (bAdd==true)
       {
            bAdd=false;
            var control = grdDTL.GetGridControl();
		    grdDTL.AddRow();
		    grdDTL.SetCellBgColor(1,2,grdDTL.rows -1 ,2,0xd4d3ff);
		    var row = control.Rows  - 1;
    		
		    grdDTL.SetGridText( row , 1, txtCodeGrp_PK.GetData());
		    grdDTL.GetGridControl().TopRow=row;
		    preparedModify();
		    
       }
        if (grdDTL.rows>1)
        {
            grdDTL.SetCellBgColor(1,2,grdDTL.rows -1 ,2,0xd4d3ff);
            
        }
    }   
   
}
function CloseOnClick()
{

    var obj=new Array();
    obj[0]=flag;
    if (grdDTL.row>0)
        obj[1]=grdDTL.GetGridData(grdDTL.row,4);
    else
        obj[1]=0;
    
	window.returnValue = obj; 
	window.close();
}
//-------------------------
function EXITOnClick()
{
	CloseOnClick()
}
//--------------------------
function OnSelect()
{
    if (grdDTL.col==2)
        CloseOnClick()
}
 </script>

<body  bgcolor='#F5F8FF'>
<gw:data id="datCode_DTLs"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="comm.sp_sel_code_dtls" procedure="comm.sp_upd_code_dtls"> 
                <input> 
                    <input bind="txtCodeGrp_PK" /> 
                    <input bind="txtInput_CODE" /> 
                    <input bind="txtInput_CODE_NM" /> 
                    <input bind="txtInput_USEYN" /> 
                </input> 
                <output bind="grdDTL" /> 
            </dso> 
       </xml> 
    </gw:data> 
    
    <gw:data id="datCodeGrp"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process"  procedure="comm.sp_pro_codegrppk" > 
                <input> 
                    <input bind="txtFlag" /> 
                    <input bind="txtInput_CODEGRP" /> 
                    <input bind="txtInput_CODEGRP_NM" /> 
                </input> 
                <output >
                    <output bind="txtCodeGrp_PK" />
                    <output bind="txtCODE_LEN" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
<!-- MainTable -->
<table    style='margin-left:10px' cellpadding="0" cellspacing="0" border="1" style="width:100%;height:85%">
	<tr width="100%" height=100% cellpadding="0" cellspacing="0">
	    <td>
	        <table border=1 cellpadding="0" cellspacing="0">
            <tr style="width:100%;height:5%;border:0" valign="middle" cellpadding="0" cellspacing="0">
                    <td style="width:10%;border:0" >
                        <gw:radio id="rdoKIND" value="2" > 
                            <span value="2" > <font color="black" ><b>Code Group</b> </font></span>
                        </gw:radio >
                    </td>						
		            <td width="10%" valign="middle" style="border:0"><gw:textbox id="txtInput"  csstype="filter" styles='width:95%' onenterkey ="OnSearch()" />&nbsp;</td>
		            <td width="10%" align="right" style="border:0"><font color="black" ><b></b>&nbsp;</font></td>
		            <td width="7%" style="border:0"></td>
		            <td width="7%" align="right" style="border:0"><font color="black" ><b>Length</b>:&nbsp;</font></td>
		            <td width="7%" style="border:0"><gw:textbox id="txtCODE_LEN" styles='width:100%'	 csstype="mandatory"/> </td>
		            <td width="6%" align="right" style="border:0"><font color="black" ><b>Active</b>:&nbsp;</font></td>
		            <td width="2%" style="border:0"><gw:checkbox id="txtInput_USEYN"   	  value="1" defaultvalue="1|0" onchange="OnSearch()"/></td>
		            <td width="2%" style="border:0"></td>
		            <td width="3%" style="border:0" align=right ><gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch()" />  <td>
                    <td width="3%" style="border:0"><gw:imgBtn img="new"     alt="new"      id="ibtnAdd" 	onclick="AddOnClick()" /></td>					
		            <td width="3%" style="border:0"><gw:imgBtn img="delete"  alt="delete"   id="ibtnDelete" 	onclick="DeleteOnClick()" /></td>  
		            <td width="3%" style="border:0"><gw:imgBtn img="udelete" alt="Undelete" id="ibtnDelete1" onclick="UnDeleteOnClick()" /></td>  
		            <td width="3%" style="border:0"><gw:imgBtn img="save"    alt="Save"     id="ibtnUpdate" 	onclick="UpdateOnClick()" /></td>
		            <td width="3%"style="border:0"><gw:imgBtn img="cancel"    alt="Close"     id="ibtnClose" 	onclick="CloseOnClick()" /></td>
	            </tr>
            	<tr style="width:100%;height:5%;border:0" valign=top cellpadding="0" cellspacing="0">
            	    <td width="100%" colspan=16 valign="middle"><b style="color:Red;font-size:13">Note: Double Click on ORD column to select this row!</b></td>
            	</tr>								
	            <tr style="width:100%;height:90%;border:1" valign=top cellpadding="0" cellspacing="0">
		            <td width="100%" colspan=16 >
				            <gw:grid   
					            id="grdDTL"  
					            header="_PK|_TC_ABCODE_MST_PK|ORD|DEF YN|Code|Code Name|Code Local Name|Code Foreign Name|Group Code|SYS Y/N|Use|NUM_VALUE1|NUM_VALUE2|NUM_VALUE3|CHA_VALUE1|CHA_VALUE2|CHA_VALUE3|_DEL_IF|_"   
					            format="0|0|0|3|0|0|0|0|2|3|3|0|0|0|0|0|0|0|0"  
					            aligns="0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
					            defaults="||||||||||-1||||||||"  
					            editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
					            widths="0|0|800|800|0|2000|2000|2000|1500|0|0|0|0|0|0|0|0|0|0"  
					            styles="width:100%; height:480"   
					            sorting="T"   
					            param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"  
					            oncellclick="checkData();checkDefault()" oncelldblclick="OnSelect()"/> 

		            </td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
	   
    <gw:textbox id="txtCodeGrp_PK"  styles="display:none" />
    <gw:textbox id="txtInput_CODEGRP"  styles="display:none" />
    <gw:textbox id="txtInput_CODEGRP_NM"  styles="display:none" />
    <gw:textbox id="txtInput_CODE" styles="display:none"/>
    <gw:textbox id="txtInput_CODE_NM" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>	
	

</body>
</html>
