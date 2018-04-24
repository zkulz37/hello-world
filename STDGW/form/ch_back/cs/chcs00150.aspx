<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
    function BodyInit()
    {
        BindDataList();
        datProStatus.Call();
        
    }
    function auto_resize_column(obj,col1,col2,font_size)
    {
      if(font_size!=0)
            obj.GetGridControl().FontSize =font_size;   
      obj.GetGridControl().AutoSize(col1,col2,false,0);  
    }
    function BindDataList()
    {
        <%=ESysLib.SetGridColumnComboFormat("grdEmp",5,"select code, code_nm from vhr_hr_code where id='HR0129'") %>    
        <%=ESysLib.SetGridColumnComboFormat("grdEmp",7,"select code, code_nm from vhr_hr_code where id='HR0040'") %>   
        <%=ESysLib.SetGridColumnComboFormatString2("grdEmp",8,"Y|Yes|N|No") %>
    }
    
    function OnSetToGrid(n)
    {
        ctrl=grdEmp.GetGridControl();
        if(n==1)//amount
        {
            if(txtAmount.text=="")
            {
                alert("Amount not blank! \n Số tiền không được bỏ trống!");
                return;
            }
            if(!CheckNumber(txtAmount.text))
            {
                alert("Amount not a number! \n Số tiền không phải là số!");
                return;
            }
            if(grdEmp.rows>1)
            {  
                 if (ctrl.SelectedRows>1) 
                 {
                       for(var i=0;i<ctrl.SelectedRows;i++)
                           grdEmp.SetGridText(ctrl.SelectedRow(i),6,txtAmount.text);
                 }
                 else      
                 {
                    if(confirm("Do you want to set all rows? \n Bạn có muốn set tất cả những dòng không?"))
                    {
                        
                        for(var i=1;i<ctrl.rows;i++)
                        {
                            //if(grdEmp.GetGridData(i,6)=="")
                                 grdEmp.SetGridText(i,6,txtAmount.text);
                        }
                    }
                    else
                    {
                        if(ctrl.SelectedRows==1) 
                        grdEmp.SetGridText(ctrl.SelectedRow(0),6,txtAmount.text);           
                    }
                 }
                 
            }
             
        }
        else if(n==2)//Tax
        {       
                if(listTaxYN.value=="ALL")
                {
                    alert("Please choose Yes or No! \n Xin chọn Yes hoặc No");
                    return;
                }
                var tmp; 
                if(listTaxYN.value=="Y")
                    tmp=-1;
                else
                    tmp=0;
               
                if(grdEmp.rows>1)
                {  
                     if (ctrl.SelectedRows>1) 
                     {
                           for(var i=0;i<ctrl.SelectedRows;i++)
                               grdEmp.SetGridText(ctrl.SelectedRow(i),9,tmp);
                     }
                     else     
                     {
                        if(confirm("Do you want to set all rows? \n Bạn có muốn set tất cả những dòng không?"))
                        {
                            for(var i=1;i<ctrl.rows;i++)
                                {
                                         grdEmp.SetGridText(i,9,tmp);
                                }
                           
                         }
                         else 
                         {
                               if(ctrl.SelectedRows==1)                              
                               grdEmp.SetGridText(ctrl.SelectedRow(0),9,tmp);                      
                         }
                     }
                     
                }
           
        }
        else if(n==3) // Set Kind
        {
           var temp2;
           temp2=listKind.value;
           
                if(grdEmp.rows>1)
                {  
                     if (ctrl.SelectedRows>1) 
                     {
                           for(var i=0;i<ctrl.SelectedRows;i++)
                               grdEmp.SetGridText(ctrl.SelectedRow(i),5,temp2);
                     }
                     else if(ctrl.SelectedRows==1)     
                     {
                        if(confirm("Do you want to set all rows? \n Bạn có muốn set tất cả những dòng không?"))
                        {
                            for(var i=1;i<ctrl.rows;i++)
                                {
                                         grdEmp.SetGridText(i,5,temp2);
                                }
                           
                         }
                         else                                
                               grdEmp.SetGridText(ctrl.SelectedRow(0),5,temp2);                         
                     }
                }      
        }
        else if(n==4) // Set Kind Money
        {
           var temp;
           temp=listKindMoney.value;
                if(temp=="ALL")
                {
                    alert("Please choose kind money! \n Xin chọn một loại tiền!");
                    return;
                }
                if(grdEmp.rows>1)
                {  
                     if (ctrl.SelectedRows>1) 
                     {
                           for(var i=0;i<ctrl.SelectedRows;i++)
                               grdEmp.SetGridText(ctrl.SelectedRow(i),7,temp);
                     }
                     else      
                     {
                        if(confirm("Do you want to set all rows? \n Bạn có muốn set tất cả những dòng không?"))
                        {
                            for(var i=1;i<ctrl.rows;i++)
                                {
                                         grdEmp.SetGridText(i,7,temp);
                                }
                           
                         }
                         else   
                         {
                            if(ctrl.SelectedRows==1)                             
                               grdEmp.SetGridText(ctrl.SelectedRow(0),7,temp); 
                         }                        
                     }
                }      
        }
        
        else if(n==5)//Set Company Pay YN
        {
            var temp;
            temp=listPay.value;
                if(temp=="ALL")
                {
                    alert("Please choose Yes or No! \n Xin chọn Yes hoặc No");
                    return;
                }
                if(grdEmp.rows>1)
                {  
                     if (ctrl.SelectedRows>1) 
                     {
                           for(var i=0;i<ctrl.SelectedRows;i++)
                               grdEmp.SetGridText(ctrl.SelectedRow(i),8,temp);
                     }
                     else      
                     {
                        if(confirm("Do you want to set all rows? \n Bạn có muốn set tất cả những dòng không?"))
                        {
                            for(var i=1;i<ctrl.rows;i++)
                                {
                                         grdEmp.SetGridText(i,8,temp);
                                }
                           
                         }
                         else   
                         {
                            if(ctrl.SelectedRows==1)                             
                               grdEmp.SetGridText(ctrl.SelectedRow(0),8,temp); 
                         }                        
                     }
                }
        }
    }
    function OnShowPopup(strtemp,objlist)
    {    
          if (strtemp==3 )
    
                {
                    var strcom;
                    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
                    //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
                    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
                    if (obj!=null)
                    {
			            listOrg.value = obj;
 
                    }
                }

    }
    function OnAdd()
    {
        
        if(listKind.value =="ALL")
        {
             alert("You must choose kind! \n Bạn phải chọn loại trợ cấp!");
        }
        else
        {
            var fpath = System.RootURL + "/form/ch/ae/chcs00150_add_popup.aspx?";
            var aData=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:30;dialogLeft:80;dialogTop:150;edge:sunken;scroll:yes;unadorned:yes;help:no');
            
            if ( aData != null )
	        {  	 
		        var len=aData.length;
		        var i;
		        for (i=0;i<len-1;i++)		
		        {   
		                var irow=grdEmp.rows;
		                aRow=aData[i];
		            
		                grdEmp.AddRow();
		                grdEmp.SetGridText(irow,1,aRow[0]);		// group
		                grdEmp.SetGridText(irow,2,aRow[1]);		// emp id
		                grdEmp.SetGridText(irow,3,aRow[2]);		// name 
		                grdEmp.SetGridText(irow,4,dateHealthFrom.text);
    		            grdEmp.SetGridText(irow,5,listKind.value);
    		            grdEmp.SetGridText(irow,11,aRow[4]);
	             }
	        }

	        lblRecord.text = grdEmp.rows-1 +" Record(s)";
	        grdEmp.SetCellBgColor(1,5,grdEmp.rows-1,10,0xFFEEFF); // Set Color for column not edit
	    }	
    }
   
    function OnSave()
    {    
        var flag=1;
        for(var i=1;i<grdEmp.rows-1;i++)
        {           
            if(!CheckNumber(grdEmp.GetGridData(i,6)))
            {
                alert("Amount not a number!\n Số tiền không phải là một số");
                flag=0;
                break;
            }
            else flag=1;
        }
        if(flag==1)
        {         
            if(confirm("Do you want save"))
            {
                listKind.value="ALL";
                datGridEmp.Call();                
            }
        }
        
    }
    function OnDelete()
    {
        if(confirm("Do you want to delete?\n Bạn có chắc chắn xóa?"));
        grdEmp.DeleteRow();
    }
    function OnSearch()
    {
        datGridEmp.Call("SELECT");
    }
    function OnDataReceive(obj)
    {
        
        if(obj.id=="datProStatus")
        {
            
            if(txtStatusClose.text=="Y")
            {
                btnAdd.SetEnable(0);
                btnSave.SetEnable(0);
                btnDelete.SetEnable(0);
            }
            else
            {
                btnAdd.SetEnable(1);
                btnSave.SetEnable(1);
                btnDelete.SetEnable(1);
            }
            if(txtCheckData.text ==0)
            {
                btnSetMig.SetEnable(1);
                dateMig.SetEnable(1);
            }
            else 
            {
                btnSetMig.SetEnable(0);
                dateMig.SetEnable(0);
            }
        }
        if(obj.id=="datGridEmp")
        {
            lblRecord.text= grdEmp.rows-1 +" Record(s)";
            if(grdEmp.rows>1)
            {
                grdEmp.SetCellBgColor(1,5,grdEmp.rows-1,10,0xFFEEFF); // Set Color for column not edit
                btnSave.SetEnable(true); 
            }
            else btnSave.SetEnable(false);
        }
        if(obj.id=="datProSetAllow")
        {
            if(txtResult.text=='0')
            {
                alert("You has replicated successful");
                datGridEmp.Call("SELECT");
            }
            else
                alert("prelicate error!\n Tái tạo gặp lỗi.");    
        }
        auto_resize_column(grdEmp,0,grdEmp.cols-1,9); // Set auto width for column
    }
    function OnChangeDate()
    {
        datProStatus.Call();
        
    }

    function OnSetMig2()
    {
        datProSetAllow.Call();
    }
    function CheckNumber(value)
    {

          var flag=1;
          var reg=/^\d+$/;
          if(!reg.test(value))
            return false
          else return true

    }
</script>
<body>
<%-- Data xml --%>

<gw:data id="datProSetAllow" onreceive="OnDataReceive(this)">
    <xml>
        <dso type="process" procedure="hr.sp_pro_allow_amb">
            <input>
                <input bind="dateMig"/>
                <input bind="dateHealthFrom"/>
            </input>
            <output>
               <output bind="txtResult" />   
            </output>
        </dso>
    </xml>
</gw:data>
<gw:data id="datProStatus" onreceive="OnDataReceive(this)">
    <xml>
        <dso type="process" procedure="hr.sp_status_amb"> 
            <input>
                <input bind="dateHealthFrom"/>
            </input>
            <output>
                <output bind="txtStatusClose"></output>
                <output bind="txtCheckData"></output>
            </output>
        </dso>
    </xml>
</gw:data>
<gw:data id="datGridEmp" onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid" parameter="0,2,4,5,6,7,8,9,10,11" function="hr.sp_sel_allow_amb" procedure="HR.sp_upd_allow_amb">
            <input bind="grdEmp">
                <input bind="listOrg"/>
                <input bind="listSearch"/>
                <input bind="txtSearchBy" />
                <input bind="dateHealthFrom" />
                <input bind="listKind" />
                <input bind="listTaxYN" />
            </input>
            <output bind="grdEmp"></output>
        </dso>
    </xml>
</gw:data>
    <table>
        <tr>
            <td width=10% align="right"> <a title="click here to choose Organization" onclick="OnShowPopup(3,'')" href="#tips">Organization</a>               
            </td>
            <td width=20% colspan=2>
                            <gw:list id="listOrg" value="ALL" onchange="OnChangeOrg()" maxlen="100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a order by a.seq")%>
                                    |ALL|Select All
                                </data>
                            </gw:list>
            </td>
            <td width=3%>
            </td>
            <td width=8% align="right"> Work Mon
            </td>
            <td width=10% align="left"> <gw:datebox id="dateHealthFrom" lang="<%=Session("Lang")%>" type="month" onchange="OnChangeDate()"></gw:datebox>
            </td>
            <td width=3%>
            </td>
            <td width=8% align="right">Amount
            </td>
            <td width=10%><gw:textbox id="txtAmount" text=""></gw:textbox>
            </td>
            <td width=3%><gw:imgBtn img="set" id="btnSetAmount" onclick="OnSetToGrid(1)" alt="Set Amount"></gw:imgBtn> 
            </td>
            <td width=3%></td>
            <td width=5% align="right">Tax
            </td>
            <td width=10%><gw:list id="listTaxYN" value="ALL">
                            <data>
                                |Y|Yes|N|No|ALL|Select All
                            </data>
                          </gw:list>
            </td>
            
            <td width=3%><gw:imgBtn img="set" id="btnSetTax" onclick="OnSetToGrid(2)" alt="Set Tax"></gw:imgBtn> 
            </td>
            <td width=3%>
            </td>
            <td width=3%><gw:imgBtn img="search" id="btnSearch" onclick="OnSearch()"></gw:imgBtn>
            </td>
            <td width=3%><gw:imgBtn img="popup" alt="Add" id="btnAdd" onclick="OnAdd()"></gw:imgBtn>
            </td>
            <td width=3%><gw:imgBtn img="save" id="btnSave" onclick="OnSave()"></gw:imgBtn>
            </td>
            <td width=3%> <gw:imgBtn img="delete" id="btnDelete" onclick="OnDelete()"></gw:imgBtn>
            </td>
        </tr>
        <tr>
            <td width=10% align="right"> Search By               
            </td>
            <td width=20% colspan=2>
                            <gw:list id="listSearch" value="2">
                                <data>
                                    LIST|1|Name|2|Emp ID
                                </data>
                            </gw:list>
            </td>
           
            <td width=18% colspan=3> <gw:textbox id="txtSearchBy" text=""></gw:textbox>
            </td>
            
            <td width=3%>
            </td>
            <td width=8% align="right">Kind
            </td>
            <td width=10%><gw:list id="listKind" value="ALL">
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0129'")
                                        %> |ALL|Select All
                                </data>
                            </gw:list>
            </td>
            <td width=3%><gw:imgbtn img="set" id="btnSetKind" onclick="OnSetToGrid(3)" alt="Set Kind" ></gw:imgbtn> 
            </td>
            <td width=3%></td>
            <td width=5% align="right">Replicate
            </td>
            <td width=10%><gw:datebox id="dateMig" lang="<%=Session("Lang")%>" type="month" onchange="OnChangeMig()"></gw:datebox>
            </td>
            
            <td width=3%><gw:imgbtn img="process" id="btnSetMig" onclick="OnSetMig2()" alt="Set Replicate"></gw:imgbtn>
            </td>
            <td width=3%>
            </td>
            <td width=3% colspan=4><gw:label id="lblRecord" text="0 Record(s)" styles="color:red;width:90%;font-weight: bold;font-size:13"></gw:label>
            </td>
           
        </tr>
        <tr>
            <td width=10% align="right">Kind Money            
            </td>
            <td width=15%> <gw:list id="listKindMoney" value="ALL">
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040'")
                                        %> |ALL|Select All
                                </data>
                            </gw:list>
            
            </td>
            <td width=5%><gw:imgbtn id="btnSetMoney" img="set" onclick="OnSetToGrid(4)" alt="Set kind money"></gw:imgbtn>
            </td>
            
            <td width=11% colspan=2>Company Pay 
            </td>
            <td width=10%> 
                            <gw:list id="listPay" value="ALL">
                                <data>
                                    |Y|Yes|N|No|ALL|Select All
                                </data>
                            </gw:list>
            </td>
            <td width=3%><gw:imgbtn id="btnSetPay" img="set" onclick="OnSetToGrid(5)" alt="Set kind pay"></gw:imgbtn>
            </td>
            <td width=8% align="right">
            </td>
            <td width=10%>
            </td>
            <td width=3%>
            </td>
            <td width=3%></td>
            <td width=5% align="right">
            </td>
            <td width=10%>
            </td>
            <td width=3%>
            </td>
            <td width=3%>
            </td>
            <td width=3% colspan=4>
            </td>
           
        </tr>
        
    </table>
    <div>
       
                <table id="Table1" style="height:85%; width: 100%;" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:50%" valign="top">
                        <td colspan=15 style="width:78%;height:50%;"> 
                             <gw:grid   
                                id="grdEmp"  
                                header="_PK|Organization|Emp ID|Full Name|Work Month|Kind Name|Amount|Kind Money|Company Pay YN|Tax YN|Remark|_emp_pk"   
                                format="0|0|0|0|0|2|1|2|2|3|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||"    
                               editcol="0|0|0|0|1|1|1|1|1|1|1|0"  
                                widths="1500|2500|1500|2500|1500|1500|1500|1500|1500|1500|1500|0"  
                                styles="width:100%; height:100%"   
                                sorting="T"/> 
                                
                        </td>
                    </tr>
                </table>
    </div>
    <gw:textbox id="txtStatusClose" styles="display:none"></gw:textbox>
    <gw:textbox id="txtResult" styles="display:none"></gw:textbox>
    <gw:textbox id="txtCheckData" styles="display:none"></gw:textbox>
</body>
</html>
