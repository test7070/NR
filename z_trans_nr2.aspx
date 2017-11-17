<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var t_carteam = null;
            var t_calctypes = null;
            
            aPop = new Array(['txtXstraddr', 'lblXstraddr', 'straddr_rj', 'noa', 'txtXstraddr', 'straddr_rj_b.aspx'],
                             ['txtXendaddr', 'lblXendaddr', 'endaddr_rj', 'noa', 'txtXendaddr', 'endaddr_rj_b.aspx'],
                             ['txtXcarno', 'lblXcarno', 'car2', 'a.noa,f.driver,a.driverno', 'txtXcarno', 'car2_b.aspx']);
            
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_trans_nr2');
            });
			
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_trans_nr2',
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_trans_nr.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
                        type : '0', //[3]
                        name : 'proj',
                        value : q_getPara('sys.project')
                    },{
                        type : '0', //[4]
                        name : 'taxrate',
                        value : q_getPara('sys.taxrate')
                    }, {
                        type : '1', //[5][6]    1
                        name : 'xtrandate'
                    }, { 
                        type : '2', //[7][8]    2
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp,nick',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[9][10]    3
                        name : 'xdriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {
                        type : '6', //[11]       4
                        name : 'xcarno'
                    }, {
                        type : '6', //[12]       5
                        name : 'xstraddr'
                    }, {
                        type : '6', //[13]       6
                        name : 'xendaddr'
                    }, {
                        type : '6', //[14]       7
                        name : 'xprice'
                    }]
                });
                $('#txtXtrandate1').mask('999/99/99');
                $('#txtXtrandate1').datepicker();
                $('#txtXtrandate2').mask('999/99/99');
                $('#txtXtrandate2').datepicker();
                $('#lblXcarno').parent().parent().width(610).find('input[type="text"]').width(240);
                q_popAssign();
                q_langShow();
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>