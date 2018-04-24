<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var check_init=0;
var p_ProbationSalary= 44;
var p_AllowAmt1= 46;

function BodyInit()
{ 	
	System.Translate(document);
    grdSelect.GetGridControl().ScrollTrack=true;
    //txtLang.text = v_language;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
    
    datAllowance.Call();
    
}


function OnDataReceive(obj)
{
    if (obj.id=="datAllowance")
    {

        datSelectTitle.Call();

        

    }
    else if (obj.id=="datSelectTitle")
    {
        var icol=p_AllowAmt1; //value of allowance col
        grdSelect.SetGridText(icol,1,grdAllowance.GetGridData(1,0));
        grdSelect.SetGridText(icol+1,1,grdAllowance.GetGridData(1,1));
        grdSelect.SetGridText(icol+2,1,grdAllowance.GetGridData(1,2));
        grdSelect.SetGridText(icol+3,1,grdAllowance.GetGridData(1,3));
        grdSelect.SetGridText(icol+4,1,grdAllowance.GetGridData(1,4));
        grdSelect.SetGridText(icol+5,1,grdAllowance.GetGridData(1,5));
        grdSelect.SetGridText(icol+6,1,grdAllowance.GetGridData(1,6));
        grdSelect.SetGridText(icol+7,1,grdAllowance.GetGridData(1,7));

        grdSelect.SetGridText(icol,2,grdAllowance.GetGridData(1,16));
        grdSelect.SetGridText(icol+1,2,grdAllowance.GetGridData(1,17));
        grdSelect.SetGridText(icol+2,2,grdAllowance.GetGridData(1,18));
        grdSelect.SetGridText(icol+3,2,grdAllowance.GetGridData(1,19));
        grdSelect.SetGridText(icol+4,2,grdAllowance.GetGridData(1,20));
        grdSelect.SetGridText(icol+5,2,grdAllowance.GetGridData(1,21));
        grdSelect.SetGridText(icol+6,2,grdAllowance.GetGridData(1,22));
        grdSelect.SetGridText(icol+7,2,grdAllowance.GetGridData(1,23));

/*        grdSelect.GetGridControl().RowHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdSelect.GetGridControl().RowHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        grdSelect.GetGridControl().RowHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        grdSelect.GetGridControl().RowHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        grdSelect.GetGridControl().RowHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        grdSelect.GetGridControl().RowHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        grdSelect.GetGridControl().RowHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        grdSelect.GetGridControl().RowHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        var b = !(Number(grdAllowance.GetGridData(1,13)));
        alert(b);*/
        for(var i = 0; i < 8; i++)
        {
            var b = !(Number(grdAllowance.GetGridData(1,8 + i)));
            if (b == true)
            {
                grdSelect.GetGridControl().RemoveItem(icol + i);
                icol = icol - 1;
            }
        }
        datSal_security.Call();
    }
    else if (obj.id=="datSal_security")
    {
        if(txt_sal_security.text=='N') 
        {
            var icol=p_ProbationSalary; //value of probation salary
            for (var i=0;i<=9;i++)
                grdSelect.GetGridControl().RowHidden(icol+i)=1;
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
	    else
		    check_init=1;
    }   
}  


function OnChangeLang()
{
    //
}

function OnSelect(n)
{
    var ctrl = grdSelect.GetGridControl();
    switch (n)
    {
        case 1:
        {
            if(ctrl.SelectedRows <= 0)
            {
	            alert("Please select title.");
	            return;
	        }

            for(var i = 0; i < ctrl.SelectedRows; i++)
            {
                var row = ctrl.SelectedRow(i);
                if (grdSelect.GetGridData(row,7) != "1")
	            {
                    grdSelected.AddRow();
	                grdSelected.SetGridText(grdSelected.rows-1 , 0, grdSelected.rows - 1); 	
	                grdSelected.SetGridText(grdSelected.rows-1 , 1, grdSelect.GetGridData(row,1)); 	//title 			
	                grdSelected.SetGridText(grdSelected.rows-1 , 2, grdSelect.GetGridData(row,2));  //title V
	                grdSelected.SetGridText(grdSelected.rows-1 , 3, grdSelect.GetGridData(row,3));  //field
	                grdSelected.SetGridText(grdSelected.rows-1 , 4, grdSelect.GetGridData(row,4));  //field V
	                grdSelected.SetGridText(grdSelected.rows-1 , 5, grdSelect.GetGridData(row,5));  //colum num
                    grdSelected.SetGridText(grdSelected.rows-1 , 6, grdSelect.GetGridData(row,6));  //pk
		            grdSelect.SetGridText(row , 7, "1");	
                    grdSelected.SetGridText(grdSelected.rows-1 , 7, grdSelect.GetGridData(row,7));
	            }
            }
        
            for(var i = ctrl.rows - 1; i >0 ; i--)
                if (grdSelect.GetGridData(i,7) == "1")
                    ctrl.RemoveItem(i);//ctrl.RowHidden(i) = true;

            break; 
        }
        case 2:
        {
            for(var i = 1; i < ctrl.rows; i++)
            {
                //var row = ctrl.SelectedRow(i);
                if (grdSelect.GetGridData(i,7) != "1")
	            {
                    
                    grdSelected.AddRow();
	                grdSelected.SetGridText(grdSelected.rows-1 , 0, grdSelected.rows - 1); 	
	                grdSelected.SetGridText(grdSelected.rows-1 , 1, grdSelect.GetGridData(i,1)); 				
	                grdSelected.SetGridText(grdSelected.rows-1 , 2, grdSelect.GetGridData(i,2)); 
	                grdSelected.SetGridText(grdSelected.rows-1 , 3, grdSelect.GetGridData(i,3));
	                grdSelected.SetGridText(grdSelected.rows-1 , 4, grdSelect.GetGridData(i,4));
	                grdSelected.SetGridText(grdSelected.rows-1 , 5, grdSelect.GetGridData(i,5));//colunm num
                    grdSelected.SetGridText(grdSelected.rows-1 , 6, grdSelect.GetGridData(i,6));  //pk
                    grdSelect.SetGridText(i , 7, "1");
                    grdSelected.SetGridText(grdSelected.rows-1 , 7, grdSelect.GetGridData(i,7));
		        }
            }
        
            for(var i = ctrl.rows - 1; i >0 ; i--)
                    ctrl.RemoveItem(i);

            break;    
        }   
    }
}

function OnRemove(n)
{
    var ctrl = grdSelected.GetGridControl();
    switch (n)
    {
        case 1:
        {
            if(ctrl.SelectedRows <= 0)
            {
	            alert("Please select title.");
	            return;
	        }

            for(var i = 0; i < ctrl.SelectedRows; i++)
            {
                var row = ctrl.SelectedRow(i);
                if (grdSelected.GetGridData(row,7) != "0")
	            {
                    grdSelect.AddRow();
	                grdSelect.SetGridText(grdSelect.rows-1 , 0, grdSelect.rows - 1); 	
	                grdSelect.SetGridText(grdSelect.rows-1 , 1, grdSelected.GetGridData(row,1)); 	//title 			
	                grdSelect.SetGridText(grdSelect.rows-1 , 2, grdSelected.GetGridData(row,2));  //title V
	                grdSelect.SetGridText(grdSelect.rows-1 , 3, grdSelected.GetGridData(row,3));  //field
	                grdSelect.SetGridText(grdSelect.rows-1 , 4, grdSelected.GetGridData(row,4));  //field V
	                grdSelect.SetGridText(grdSelect.rows-1 , 5, grdSelected.GetGridData(row,5));  //colum num
                    grdSelect.SetGridText(grdSelect.rows-1 , 6, grdSelected.GetGridData(row,6));  //pk
		            grdSelected.SetGridText(row , 7, "0");	
                    grdSelect.SetGridText(grdSelect.rows-1 , 7, grdSelected.GetGridData(row,7));
	            }
            }
        
            for(var i = ctrl.rows - 1; i >0 ; i--)
                if (grdSelected.GetGridData(i,7) == "0")
                    ctrl.RemoveItem(i);//ctrl.RowHidden(i) = true;

            break; 
        }
        case 2:
        {
            for(var i = 0; i < ctrl.rows; i++)
            {
                //var row = ctrl.SelectedRow(i);
                if (grdSelect.GetGridData(i,7) != "1")
	            {
                    
                    grdSelect.AddRow();
	                grdSelect.SetGridText(grdSelect.rows-1 , 0, grdSelect.rows - 1); 	
	                grdSelect.SetGridText(grdSelect.rows-1 , 1, grdSelected.GetGridData(i,1)); 	//title 			
	                grdSelect.SetGridText(grdSelect.rows-1 , 2, grdSelected.GetGridData(i,2));  //title V
	                grdSelect.SetGridText(grdSelect.rows-1 , 3, grdSelected.GetGridData(i,3));  //field
	                grdSelect.SetGridText(grdSelect.rows-1 , 4, grdSelected.GetGridData(i,4));  //field V
	                grdSelect.SetGridText(grdSelect.rows-1 , 5, grdSelected.GetGridData(i,5));  //colum num
                    grdSelect.SetGridText(grdSelect.rows-1 , 6, grdSelected.GetGridData(i,6));  //pk
                    grdSelected.SetGridText(i , 7, "0");	
                    grdSelect.SetGridText(grdSelect.rows-1 , 7, grdSelected.GetGridData(i,7));
		        }
            }
        
            for(var i = ctrl.rows - 1; i >0 ; i--)
                ctrl.RemoveItem(i);

            break;    
        }   
    }
}

function OnReport()
{
    var aData =new Array();
    var j,tmp;
    j = 0;
    var bSelect=false;
    for (var i=1;i<grdSelected.rows;i++)
    {
        var aRow=new Array();
        bSelect=true;
        aRow[0]=grdSelected.GetGridData(i,5) //column num
        aData[j]=aRow;
        j=j+1;
    }

    if (bSelect == true)
    {
        var RowSel = new Array();
        RowSel[0] = lstLang.value;
        aData[j] = RowSel;
        j=j+1;
    }
    
    window.returnValue = aData; 			
	this.close();
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_sp_sel_allow_salary_pcss" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_PRO_10010003_SAL_DISPLAY"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_sal_security" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datSelectTitle" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="grid" function="hr_sp_sel_10010003_title" > 
                <input bind="grdSelect" >
                </input>
                <output  bind="grdSelect" />
            </dso> 
        </xml> 
</gw:data>

<table width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
    <tr> 
	    <td  width="40%" valign ="top" >
		    <table align = top  width="100%" style="height:100%">
                <tr style="border:1;width:100%;height:5%" valign="top">                    
                    <td width="100%" colspan=2 align="center"><gw:label id="lbltitle"  text="Select Title Empployee Information" maxlen = "100" styles="color:red;width:90%;font-weight: blod;font-size:14" /></td>
                </tr>   
                <tr width="3%" style="border:0;height:5%" align="right">
                    <td width="100%" colspan=2 align="center"></td>
                </tr>
                <tr style="border:1;width:100%;height:90%" valign="top">
                    <td colspan=2 style="width:100%;height:100%;">  
                       
                                    <gw:grid   
                                    id="grdSelect"  
			                        header="_No|Title|Tiêu Đề|_Field_E|_Field_V|_Col_num|_pk|_Status"   
			                        format="0|0|0|0|0|0|0|0"  
			                        aligns="0|0|0|0|0|0|0|0"  
			                        defaults="||||||||"  
			                        editcol="0|0|0|0|0|0|0|0"  
			                        widths="100|1500|1500|0|0|0|0|0"  
			                        styles="width:100%; height:100%"   
                                    sorting="F"
			                        autosize="true"
                                    /> 
                              
                    </td>
                </tr>
                </table>
	    </td> 
        <td width="2%" valign ="top"> 
            <table width = "100%" height="100%" valign ="top">
                <tr style="width:100%;height:30%">                    
                    <td align="center"></td>
                </tr>  
                <tr style="width:100%;height:10%">                    
                    <td align="center"><gw:button id="btnExcel1" img="next" alt="Select" text=" " onclick="OnSelect(1)" /></td>
                </tr>  
                <tr style="width:100%;height:10%">                    
                    <td align="center"><gw:button id="btnExcel2" img="end" alt="Select All" text=" " onclick="OnSelect(2)" /></td>
                </tr>    
                <tr style="width:100%;height:10%">                    
                    <td align="center"><gw:button id="btnExcel3" img="back" alt="Remove" text=" " onclick="OnRemove(1)" /></td>
                </tr>  
                <tr style="width:100%;height:10%">                    
                    <td align="center"><gw:button id="btnExcel4" img="first" alt="Remove All" text=" " onclick="OnRemove(2)" /></td>
                </tr>   
                <tr style="width:100%;height:30%">                    
                    <td align="center"></td>
                </tr> 
           </table>
        </td>
        <td  width="40%" valign ="top" >
		    <table align = top  width="100%" style="height:100%">
                <tr style="border:1;width:100%;height:5%" valign="top">                    
                    <td width="100%" colspan=5 align="center"><gw:label id="lbltitle1"  text="Selected Titles" maxlen = "100" styles="color:red;width:90%;font-weight: blod;font-size:14" /></td>
                </tr>   
                <tr>
                    <td align="right" colspan=2>Language</td>
                    <td align="left" colspan=1 style="width:25%"><gw:list  id="lstLang" value="ENG" styles='width:100%' onchange="OnChangeLang()"> 
						<data>LIST|ENG|English|VIE|Việt Nam</data> 
					    </gw:list></td>
                    <td width="10%" colspan=2 style="border:0;height:5%" align="center">
                             <gw:imgBtn id="ibtnPrint" alt="Print employee information" img="excel" text="Print Labour" onclick="OnReport()"/>	
                    </td>
                </tr>
                <tr style="border:1;width:100%;height:90%" valign="top">
                    <td colspan=5 style="width:100%;height:100%;">  
                       
                                    <gw:grid   
                                    id="grdSelected"  
			                        header="_No|Title|Tiêu Đề|_Field_E|_Field_V|_Col_num|_pk|_Status"   
			                        format="0|0|0|0|0|0|0|0"  
			                        aligns="0|0|0|0|0|0|0|0"  
			                        defaults="||||||||"  
			                        editcol="0|0|0|0|0|0|0|0"  
			                        widths="100|1500|1500|0|0|0|0|0" 
			                        styles="width:100%; height:100%"   
                                    sorting="F"
			                        autosize="true"
                                    /> 
                              
                    </td>
                </tr>
            </table>
	    </td> 
	</tr>
</table>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>

    <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 8|Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    defaults="||||||||||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200|0|0|0|0|0|0|0|0"  
    styles="display:none" 
    sorting="T"    
    />

</body>
</html>
