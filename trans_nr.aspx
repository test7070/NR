<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            // ref. trans_rj.aspx
            var q_name = "trans";
            var q_readonly = ['txtNoa','txtOrdeno','txtWorker','txtWorker2','txtTotal','txtTotal2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 5;
            q_copy = 1;
            
            var t_team = '',t_calctype='';
            
            aPop = new Array(['txtStraddrno', 'lblStraddr_tb', 'straddr_rj', 'noa', 'txtStraddrno', 'straddr_rj_b.aspx'],
                             ['txtEndaddrno', 'lblEndaddr_tb', 'endaddr_rj', 'noa', 'txtEndaddrno', 'endaddr_rj_b.aspx']
                ,['txtUccno','lblUcc','ucc','noa,product','txtUccno,txtProduct','ucc_b.aspx']
                ,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
                ,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
                ,['txtCarno', 'lblCarno', 'car2', 'a.noa,f.driver,a.driverno', 'txtCarno,txtDriver,txtDriverno', 'car2_b.aspx']);
           
            function sum() {
                if(q_cur!=1 && q_cur!=2)
                    return;
                try{
                	if($('#txtMemo').val().substring(0,1)=='#')
                	$('#txtMount4').val(round(eval($('#txtMemo').val().substring(1,$('#txtMemo').val().length)),3));    
                }catch(e){
                	
                } 
                var t_total=0,t_total2=0;
                switch($('#cmbUnit').val()){ 
                	case '趟':
                		t_total = round(q_mul(q_float('txtMount3'),q_float('txtPrice')),0);
                		break;
                	case '噸':
                		t_total = round(q_mul(q_float('txtMount4'),q_float('txtPrice')),0);
                		break;
                	default:
                		break;
                }
                switch($('#cmbUnit2').val()){ 
                	case '趟':
                		t_total2 = round(q_mul((q_float('txtDiscount')/100),q_mul(q_float('txtMount3'),q_float('txtPrice2'))),0);
                		break;
                	case '噸':
                		t_total2 = round(q_mul((q_float('txtDiscount')/100),q_mul(q_float('txtMount4'),q_float('txtPrice2'))),0);
                		break;
                	default:
                		break;
                }
                
                    
                $('#txtTotal').val(t_total);
                $('#txtTotal2').val(t_total2);     
                    
               /* var t_mount = q_add(q_float('txtInmount'),q_float('txtPton'));
                var t_mount2 = q_add(q_float('txtOutmount'),q_float('txtPton2'));
                $('#txtMount').val(q_trv(t_mount));
                $('#txtMount2').val(q_trv(t_mount2));*/
            }  
            var t_custunit='',t_driverunit='';    
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt('custunit','', 0, 0, 0, "custunit", r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                //q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
                //$('#btnIns').val($('#btnIns').val() + "(F8)");
                //$('#btnOk').val($('#btnOk').val() + "(F9)");
                
                bbmMask = [['txtDatea', r_picd],['txtTrandate', r_picd]];
                q_mask(bbmMask);
                
                q_cmbParse("cmbUnit", t_custunit);
                q_cmbParse("cmbUnit2", t_driverunit);
                
                $('#txtTrandate').change(function(e){
                	getPrice();
                });
                //---- 允許改趟數、噸數、單位、單價、折扣
                $('#txtMemo').change(function(e){
                	sum();
                });
                $('#txtMount3').change(function(e){
                	sum();
                });
                $('#txtMount4').change(function(e){
                	sum();
                });
                $('#cmbUnit').change(function(e){
                	sum();
                });
                $('#cmbUnit2').change(function(e){
                	sum();
                });
                $('#txtPrice').change(function(e){
                	sum();
                });
                $('#txtPrice2').change(function(e){
                	sum();
                });
                $('#txtDiscount').change(function(e){
                	sum();
                });
             //   q_xchgForm();
            }
            function getPrice(){
            	var t_date = $.trim($('#txtTrandate').val());
            	var t_custno = $.trim($('#txtCustno').val());
            	var t_carno = $.trim($('#txtCarno').val());
            	var t_straddrno = $.trim($('#txtStraddrno').val());
            	var t_endaddrno = $.trim($('#txtEndaddrno').val());
            	var t_productno = $.trim($('#txtUccno').val());
  				
  				if(t_date.length==0){
  					alert('請輸入交運日期!');
  					return;
  				}	
  					     
            	q_func('qtxt.query.trd_addr_nr', 'addr_nr.txt,getPrice,' 
            		+ encodeURI(t_date) 
            		+ ';'+ encodeURI(t_custno) 
            		+ ';'+ encodeURI(t_carno) 
            		+ ';' + encodeURI(t_straddrno)
            		+ ';' + encodeURI(t_endaddrno)
            		+ ';' + encodeURI(t_productno));
            }
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.trd_addr_nr':
            			var as = _q_appendData("tmp0", "", true);
                        if (as[0] != undefined) {
                        	$('#cmbUnit').val(as[0].custunit);
                        	$('#txtPrice').val(as[0].custprice);
                        	$('#cmbUnit2').val(as[0].driverunit);
                        	$('#txtPrice2').val(as[0].driverprice);
                        } else {
                        	$('#cmbUnit').val('');
                        	$('#txtPrice').val(0);
                        	$('#cmbUnit2').val('');
                        	$('#txtPrice2').val(0);
                        }
                        sum();
                		break;
                    default:
                        break;
                }
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) { 
                	case 'custunit':
                        var as = _q_appendData("custunit", "", true);
                         if(as[0] != undefined){
                            t_custunit=" ";
                            for ( i = 0; i < as.length; i++) {
                                t_custunit += (t_custunit.length > 0 ? ',' : '') + as[i].noa;
                            }
                        }
                        q_gt('driverunit','', 0, 0, 0, "driverunit", r_accy);
                        break;
                	case 'driverunit':
                        var as = _q_appendData("driverunit", "", true);
                         if(as[0] != undefined){
                            t_driverunit=" ";
                            for ( i = 0; i < as.length; i++) {
                                t_driverunit += (t_driverunit.length > 0 ? ',' : '') + as[i].noa;
                            }
                        }
                        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                       
                        break;
                }
            }
            function q_popPost(id) {
                switch(id) {
                	case 'txtCustno':
                        getPrice();
                        break;
                    case 'txtCarno':
                        getPrice();
                        break;
                    case 'txtStraddrno':
                        getPrice();
                        break;
                    case 'txtEndaddrno':
                        getPrice();
                        break;
                    case 'txtUccno':
                        getPrice();
                        break;
                    default:
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trans_rj_s.aspx', q_name + '_s', "550px", "500px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                $('#txtDatea').val(q_date);
                $('#txtDiscount').val('23');
                $('#txtTrandate').focus();
                
                $('#txtOrdeno').val('');
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
            }
            function btnPrint() {
                q_box('z_trans_nr.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'trans_nr'
		                    ,noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
                Lock(1,{opacity:0});
                $('#txtStraddr').val($('#txtStraddrno').val());    
                $('#txtEndaddr').val($('#txtEndaddrno').val());
                
                //日期檢查
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
                    alert(q_getMsg('lblDatea')+'錯誤。');
                    Unlock(1);
                    return;
                }
                if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
                    alert(q_getMsg('lblTrandate')+'錯誤。');
                    Unlock(1);
                    return;
                }
                /*if($('#txtDatea').val().substring(0,3)!=r_accy){
                    alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
                    Unlock(1);
                    return;
                }*/
                /*var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                if(t_days>60){
                    alert(q_getMsg('lblDatea')+'、'+q_getMsg('lblTrandate')+'相隔天數不可多於60天。');
                    Unlock(1);
                    return;
                }*/
                sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                t_date = (t_date.length == 0 ? q_date() : t_date).replace(/(\d+)\/(\d+)\/(\d+)/,'$1$2$3');
                if (q_cur ==1)
                    q_gtnoa(q_name, q_getPara('sys.key_trans') + t_date);
                else
                    wrServer(t_noa);        
            }

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
                    $('#txtDatea').datepicker();
                    $('#txtTrandate').datepicker();
                }
                else{
                    $('#txtDatea').datepicker('destroy');
                    $('#txtTrandate').datepicker('destroy');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                if (q_chkClose())
                        return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function checkCaseno(string){
                var key ={0:0,1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,A:10,B:12,C:13,D:14,E:15,F:16,G:17,H:18,I:19,J:20,K:21,L:23,M:24,N:25,O:26,P:27,Q:28,R:29,S:30,T:31,U:32,V:34,W:35,X:36,Y:37,Z:38};
                if((/^[A-Z]{4}[0-9]{7}$/).test(string)){
                    var value = 0;
                    for(var i =0;i<string.length-1;i++){
                        value+= key[string.substring(i,i+1)]*Math.pow(2,i);
                    }
                    return Math.floor(q_add(q_div(value,11),0.09)*10%10)==parseInt(string.substring(10,11));
                }else{
                    return false;
                }
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 1000px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 12%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewTrandate"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewCarno"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewDriver"> </a></td>
                        <td align="center" style="width:120px; color:black;"><a id="vewStraddr_tb"> </a></td>
                        <td align="center" style="width:120px; color:black;"><a id="vewEndaddr_tb"> </a></td>
                        <td align="center" style="width:100px; color:black;">品名</td>
                        <td align="center" style="width:60px; color:black;">趟</td>
                        <td align="center" style="width:60px; color:black;">噸</td> 
                        <td align="center" style="width:80px; color:black;"><a>應收金額</a></td>
                        <td align="center" style="width:80px; color:black;"><a>應付金額</a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>                     
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="trandate" style="text-align: center;">~trandate</td>
                        <td id="carno" style="text-align: center;">~carno</td>
                        <td id="driver" style="text-align: center;">~driver</td>
                        <td id="straddr" style="text-align: center;">~straddr</td>
                        <td id="endaddr" style="text-align: center;">~endaddr</td>
                        <td id="product" style="text-align: center;">~product</td>
                        <td id="mount3,3" style="text-align: right;">~mount3,3</td>
                        <td id="mount4,3" style="text-align: right;">~mount4,3</td>
                        <td id="total" style="text-align: right;">~total</td>
                        <td id="total2" style="text-align: right;">~total2</td>
                        <td id="nick" style="text-align: center;">~nick</td>
                        <td id="datea" style="text-align: center;">~datea</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr><td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td>
                            <input id="txtNoa"  type="text" class="txt c1"/>
                            <input id="txtNoq"  type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
                        <td><input id="txtTrandate"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtCustno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtComp"  type="text" style="float:left;width:50%;"/>
                            <input id="txtNick" type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
                        <td><input id="txtCarno"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
                            <input id="txtDriver"  type="text" style="float:left;width:50%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblStraddr_tb" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtStraddrno"  type="text" class="txt c1"/>
                            <input id="txtStraddr"  type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblEndaddr_tb" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtEndaddrno"  type="text" class="txt c1"/>
                            <input id="txtEndaddr"  type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
                        <td colspan="2">
                            <input id="txtUccno"  type="text" style="float:left;width:30%;"/>
                            <input id="txtProduct"  type="text" style="float:left;width:70%;"/>
                        </td>
                        <td><span> </span><a class="lbl">趟</a></td>
                        <td><input id="txtMount3"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">噸</a></td>
                        <td><input id="txtMount4"  type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a class="lbl">客戶計價單位</a></td>
                    	<td><select id='cmbUnit' class="txt c1"> </select></td>
                    	<td><span> </span><a class="lbl">單價</a></td>
                        <td><input id="txtPrice"  type="text" class="txt c1 num"/></td>
                        <td> </td>
                        <td> </td>
                    	<td><span> </span><a class="lbl">應收金額</a></td>
                    	<td>
                    		<input id="txtTotal" type="text" class="txt c1 num"/>
                    		<input id="txtMount" type="text" style="display:none;"/>
                		</td>
                    </tr>
                    <tr>
                    	<td><span> </span><a class="lbl">司機計價單位</a></td>
                    	<td><select id='cmbUnit2' class="txt c1"> </select></td>
                    	<td><span> </span><a class="lbl">單價</a></td>
                        <td><input id="txtPrice2"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">折扣%</a></td>
                        <td><input id="txtDiscount"  type="text" class="txt c1 num"/></td>
                    	<td><span> </span><a class="lbl">應付金額</a></td>
                    	<td>
                    		<input id="txtTotal2" type="text" class="txt c1 num"/>
                    		<input id="txtMount2"  type="text" style="display:none;"/>
                		</td>
                    </tr>
                    
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                    <tr style="display:none;">
                        <td><span> </span><a id="lblPton" class="lbl" style="display:none;"> </a></td>
                        <td><input id="txtPton"  type="text" class="txt c1 num" style="display:none;"/></td>
                        <td><span> </span><a id="lblPton2" class="lbl" style="display:none;"> </a></td>
                        <td><input id="txtPton2"  type="text" class="txt c1 num" style="display:none;"/></td>
                        <td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
                        <td colspan="2"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr style="display:none;">
                        <td><span> </span><a id="lblFill" class="lbl"> </a></td>
                        <td><input id="txtFill"  type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
