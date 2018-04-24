<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>
<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script type="text/javascript">

    
var v_language = "<%=Session("SESSION_LANG")%>";

var lang = "<%=Session("Lang")%>";
    var iale_days = 12;
    var flag_allowance = 0;
    var list_sal_rate;
    var l_exp = 0;
    var check_init = 0;

    function BodyInit() {
        if (v_language != "ENG")
            System.Translate(document);
        iale_days = "<%=ESysLib.SetDataSQL("select nvl(num_1,12) from tes_vhr_hr_code where id='HR0006' and code='05'")%>";
    if (iale_days == "")
        iale_day = 12;
 


    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    menu_id.text = System.Menu.GetMenuID();
	
    }

    function OnCheckExistsEmpID() {
        //alert("check");
        if (txtEMPID.text == '') {
            alert('Input EmpID');
            return;
        }
       
        datCheckID2.Call();
    }
    
    function OnDataReceive(obj) {
        if (obj.id = "datCheckID2") {
            if (txt_Exist_Emp_ID.text == "1") {
                alert('Cannot use this EmpID!');
                return;
            }
            else {
                alert('This EmpID is available for using!')
                return;
            }
        }

        if (obj.id = "datEmployee") {

            alert('CODE ===' + txtTemp.text);
            if (txtTemp.text == "1") {
                alert('Cannot use this EmpID');
                return;
            }
            else {
                alert('Add employee was done !!');
                return;
            }
        }
    }

    function OnCheckAdd() {
        if (txtFullName.text == "") {
            alert("Please input full name! \n Vui lòng nhập họ và tên");
            txtFullName.GetControl().focus();
            return;
        }
        if (dtJoinDT.value == "") {
            alert("Have to input join date! \n Vui lòng nhập ngày vào.");
            dtJoinDT.GetControl().focus();
            return;
        }
        if (Trim(lstOrg_Code.value) == "") {
            alert("Please choose Organization! \n Vui lòng chọn phòng ban");
            return;
        }

        if (Trim(lstWork_Grp.value) == "") {
                alert("Please choose Work Group ! \n");
                return;
         }
        if (txtBirthDT.text == "") {
                alert("Please input birth date! \n Vui lòng nhập ngày sinh");
                txtBirthDT.GetControl().focus();
                return;
        }
        txtPhoto_PK.text = imgFile.GetData();

        datCheckID2.Call();
      
     
        if (txt_Exist_Emp_ID.text == "1") {
            alert('ID :  ' + txtEMPID.text + ' already exist . Please try again with other ID');
            return;
            
        }
        else {
            datEmployee.Call();
            alert('Employee   : ' + txtFullName.text + ' add done !!');
            return;
        }

       
          
    }
    
    

    function CheckBirthDate() {
        var i, dt, yyyy, mm, dd, dem
        var MyDate = new Date();

        var SDay = MyDate.getDate();
        var SMonth = MyDate.getMonth();
        var SYear = MyDate.getFullYear();
        dt = Trim(txtBirthDT.text)
        //dt="-1/2/1978"
        dem = 0

        mm = ""
        dd = ""
        yyyy = dt.substr(dt.length - 4, 4);
        if (dt == "")
            return 0; //khong xet
        if (isNaN(yyyy))
            return 2;
        else
            yyyy = Number(yyyy)

        if (dt.length > 4) {
            for (var j = 0; j < dt.length; j++)
                if (dt.charAt(j) == '/')
                    dem += 1;
            if (dem != 2)
                return 3;
        }
        i = 0;
        while (i < dt.length - 4) {
            if (i < 2) {
                if (dt.charAt(i) != '/')
                    dd += "" + dt.charAt(i);
            }
            else
                if (dt.charAt(i) != '/')
                    mm += "" + dt.charAt(i);
            i += 1;
        }

        if ((dd == "") || (mm == "")) { //ngay hoac thang khong co -> chi lay nam
            txtBirthDT.text = yyyy
            if ((yyyy >= SYear) || (SYear - yyyy) < 18)
                return 1;
        }
        else //day du ngay thang
        {
            if ((SYear - yyyy) < 18)
                return 1;
            else {
                if ((Number(SYear) - Number(yyyy)) == 18)//xet toi thang, ko can xet ngay
                {
                    if (Number(mm) > Number(SMonth) + 1)
                        return 1;
                }
                //kiem tra ngay hop le
                var lday = getDaysInMonth(String(yyyy) + String(mm));
                if (Number(mm) < 1 || Number(mm) > 12)
                    return 4;
                else if ((Number(dd) > lday) || (Number(dd) < 0))
                    return 5;
            }

        }

        return 0;
    }

    function OnReset() {
              
        imgFile.SetDataText("");
        txtEMPID.text = "";
        txtFullName.text = "";     
        lstSEX.text="";
        dtJoinDT.text="";
        txtPhoto_PK.text="";

        lstOrg_Code.text ="";
        lstWork_Grp.text="";
        lstNation.text="";
        lstEthnic.text="";
        lstReligion.text="";

        txtHomePhone.text="";
        txtTel.text="";
        txtEmail.text="";
        txtLivingAdd.text="";
        txtPerAdd.text="";

        txtHeight.text="";
        txtWeight.text="";
        txtBirthDT.text="";
        lstBirthPlace.text="";
        lstJob.text="";

        lstPosition.text="";
        txtAnnualLeave.text="";

      
    }



</script>
<body bgcolor='#F5F8FF'>

 <gw:data id="datCheckID2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR_PRO_CHAE00783_CHECKEMPID" > 
                <input>
                    <input bind="txtEMPID"/>
                </input> 
                <output>
                    <input bind="txt_Exist_Emp_ID"/>                    
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmpPK_Base_EmpID" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_EMPPK_BASE_EMP_ID" > 
                <input>
                    <input bind="txtEMPID" />
					<input bind="txtUser_PK" />
                </input>
                <output>
                    <output bind="txtEmp_PK_NB" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployee" onreceive=""OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" parameter="0,1,2,3,4,5,6,7,8,9"                
                procedure="HR_UPD_CHAE00783_EMPLOYEE"> 
                <input>
                    
                    <input bind="txtEMPID"/>
                    <input bind="txtFullName"/>
                    <input bind="lstSEX"/>
                    <input bind="dtJoinDT"/>
                    <input bind="txtPhoto_PK"/>

                    <input bind="lstOrg_Code"/>					
					<input bind="lstWork_Grp"/>
                    <input bind="lstNation"/>
                    <input bind="lstEthnic"/>
                    <input bind="lstReligion"/>

                    <input bind="txtHomePhone"/>
                    <input bind="txtTel"/>
                    <input bind="txtEmail"/>
                    <input bind="txtLivingAdd"/>
                    <input bind="txtPerAdd"/>

                    <input bind="txtHeight" />
                    <input bind="txtWeight" />	                    	
                    <input bind="txtBirthDT"/>
                    <input bind="lstBirthPlace"/>
                    <input bind="lstJob"/>

                    <input bind="lstPosition"/>	
                    <input bind="txtAnnualLeave"/>	

               </input> 
                <output>
                    <input bind="txtTemp" />
                </output>
      
               
            </dso> 
        </xml> 
</gw:data>



<%--<gw:tab id="tabMain"  border=1 style="width:100%;height:120%" onpageactivate="" onclick ="OnChangeTab()"> 	
<form name="Main E" id="form1" >--%>
     <table id="main"  cellpadding="0" cellspacing="0" border=1 style="width:100%;height:80%;">
        <tr >
            <td>
                <table  width="100%" style="width:100%;height:100%;" cellpadding="0" cellspacing="0">
                    <tr style="height:5%">
                        <td colspan=11>
                            <table border=1 width=100% cellpadding="0" cellspacing="0">
                                <tr style="border:0">
                                    <td nowrap width=10%  style="border:0"><h3>EMPLOYEE ENTRY</h3></td>
                                    <td nowrap width=18%  style="border:0"></td>
                                    <td nowrap width=8%  style="border:0"></td>
                                    <td nowrap width=8%  style="border:0"></td>
                                    <td nowrap width=4%  style="border:0"></td>
                                    <td nowrap width=10% align="center"  style="border:0"></td>
                                    <td nowrap width=4% align="right"  style="border:0"></td>
                                    <td width=18%  style="border:0"></td>

                                    <td nowrap width=3%  style="border:0"></td>
                                    <td width=1%  style="border:0"></td>
                                    <td nowrap width=3%  style="border:0"> </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtn" img="in" text="Add"  onclick="OnCheckAdd()" />
                                    </td>
                                    <td width=1%  style="border:0">
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:imgBtn id="ibtnReset" alt="Reset" img="Reset" text="Reset" onclick="OnReset()" />
                                    </td>
                                   
                                </tr>
                            </table>
                        </td>
                    </tr>
                               
                    
                    <tr style="height:5%">
                        <td nowrap width=10%>Employee ID(*)</td>
                        <td nowrap width=13%>
                            <gw:textbox id="txtEMPID"  text="" 	maxlen = "10" styles='width:100%;' csstype="mandatory"  onenterkey="" />
                        </td>
                        <td nowrap width=3%>
                            <img status="show" id="imgAddress" alt="Check Employee ID" src="../../../system/images/button/icons_button/verify_on.gif" style="cursor:hand" onclick="OnCheckExistsEmpID()"  />
                        </td>
                        <td nowrap width="9%"></td>
                        <td nowrap width="12%"></td>
                        <td nowrap width="3%"></td>
                        <td nowrap width="10%"></td>
                        <td nowrap width="8%"></td>
                        <td nowrap width="1%"></td>
                        <td nowrap  width=19% colspan=2  rowspan=5 ><gw:image id="imgFile"   view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130"  />
                        </td>
                    </tr>
                    
					<tr style="height:5%">
                        <td nowrap >Full name</td>
                        <td nowrap colspan = "1"><gw:textbox id="txtFullName"  maxlen = "60" text="" styles='width:100%;' csstype="mandatory" onkeypress="" /></td>
						<td nowrap ></td>
                        <td nowrap ><a title="Click here to show sex code" onclick="OnShowPopup('HR0007',lstSEX)" href="#tips" >
                            Sex</a></td>
                        <td nowrap >
                            <gw:list  id="lstSEX" value=" " styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0007' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        <td></td>
                        <td nowrap >
                            Join Date(*)</td>
                        <td nowrap >
                            <gw:datebox id="dtJoinDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
                        </td>
                        <td nowrap colspan = "1"></td>
                     
                       
                    </tr>
					<tr style="height:5%">
                        <td nowrap>Organization(*)</td>
                        <td nowrap colspan = "1" ><gw:list  id="lstOrg_Code" value=" " maxlen = "100" styles='width:100%'onchange="" >
								<data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tes_tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
							</gw:list></td>
                        <td></td>
                        <td nowrap >Work Group(*)</td>
                        <td nowrap colspan = "1" ><gw:list  id="lstWork_Grp" value=" " maxlen = "100" styles='width:100%'onchange="" >
								<data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from tes_thr_work_group a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  order by nvl(a.seq,99999999)")%>| |Select ...
                            </data>
							</gw:list></td>
						<td nowrap colspan ="4"></td>
                    </tr>

                    <tr style="height:5%">
                        <td nowrap ><a title="Click here to show nation code" onclick="OnShowPopup('HR0009',lstNation)" href="#tips" >
                            Nation(*)</a></td>
                        <td nowrap >
                            <gw:list  id="lstNation"  styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0009' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show ethnic" onclick="OnShowPopup('HR0015',lstEthnic)" href="#tips" >
                            Ethnic</a></td>
                        <td nowrap >
                            <gw:list  id="lstEthnic"  styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0015' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show religion" onclick="OnShowPopup('HR0016',lstReligion)" href="#tips" >
                            Religion</a></td>
                        <td nowrap >
                            <gw:list  id="lstReligion"  styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0016' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        
                        
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >Home Phone</td>
                        <td nowrap >
                            <gw:textbox id="txtHomePhone"  text="" maxlen = "100" styles='width:100%' />
                        </td> 
                        <td nowrap ></td> 
                        <td nowrap >Mobile Phone</td>
                        <td nowrap >
                            <gw:textbox id="txtTel"  text=""  styles='width:100%' tabindex="35" />
                        </td>
                        <td></td>
                        <td nowrap >Email</td>
                        <td nowrap colspan=1>
                            <gw:textbox id="txtEmail"  text="" maxlen = "100" styles='width:100%' />
                        </td> 
                        <td nowrap></td>                
                    </tr>                 

                    <tr style="height:5%">
                        <td nowrap >
                            Current Addr</td>
                        <td nowrap  colspan=1 >
                            <gw:textbox id="txtLivingAdd"  text="" maxlen = "100" styles='width:100%' />
                        </td>  
                        <td>
                        </td>                                   
                        <td nowrap colspan="8">
                        </td>
                             
                    </tr>
                                 
                    <tr style="height:5%">
                        <td nowrap  >
                            Permanent Addr</td>
                        <td nowrap colspan=1>
                            <gw:textbox id="txtPerAdd"  text="" maxlen = "100" styles='width:100%'/>
                        </td>    
                        <td>
                        </td>         
                       <td nowrap >Height(cm)</td>
                        <td nowrap >
							<gw:textbox id="txtHeight"  text="" maxlen = "10" styles='width:100%'/>
						</td>
                        <td nowrap >
                        </td>
						
                        <td nowrap >Weight(kg)</td>
                        <td nowrap >
							<gw:textbox id="txtWeight"  text="" maxlen = "10" styles='width:100%'/>
						</td>     
                        <td nowrap colspan="3"></td>                                         
                    </tr>
					
                     
					
                    <tr style="height:5%" >
                        <td nowrap style="height:5%">
                            Birth Date(*)</td>
                        <td nowrap >
                            <gw:datebox id="txtBirthDT"  text="" maxlen = "10" styles='width:100%' /> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show birth place" onclick="OnShowPopup('HR0021',lstBirthPlace)" href="#tips" >
                            Birth Place</a></td>
                        <td nowrap >
                            <gw:list  id="lstBirthPlace" value=" "  maxlen = "100" styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0021' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show job code" onclick="OnShowPopup('HR0010',lstJob)" href="#tips" >
                            Job</a></td>
                        <td nowrap >
                            <gw:list  id="lstJob" value="" styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0010' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap width=4%>
                        </td>
                        <td nowrap width=5%><a title="Click here to show position code" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >
                            Position(*)</a></td>
                        <td nowrap width=12%>
                            <gw:list  id="lstPosition" value="" maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from tes_vhr_hr_code where id='HR0008' order by seq,code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >Annual Leave</td>
                        <td nowrap >
                            <gw:textbox  id="txtAnnualLeave" type="number" format="#,###,###,###.##R" text="12" styles='width:100%' />
                        </td>
                        <td nowrap colspan="9">
                        </td>

                    </tr> 

                </table>
            </td>
        </tr>
         
    </table>
<%--</form>

</gw:tab>--%>
  
  
     
     
  <%--  
  
         
    <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none;width:100%; height:15%" 
    sorting="T"    

   
/>  --%>

<gw:textbox id="txt_Exist_Emp_ID" text="" styles="display:none"/>
<gw:textbox id="txtUser_PK" styles="display:none"/>
<gw:textbox id="txtEmp_PK_NB" styles="display:none" />
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtFlag" styles="display:none"/>
<gw:textbox id="l_txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="l_flag_load" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="txtTemp" styles="display:none"/>
</body>


