{{ content() }}
{{ flashSession.output() }}

<ol class="breadcrumb">
    <li><a href="/">首页 </a></li>
</ol>

<table id="trans-table" class="table table-bordered table-hover">
    <thead>
    <tr>
        <th></th>
        <th>编号</th>
        <th>客户号</th>
        <th>客户名称</th>
        <th>帐号数</th>
        <th>账户总余额</th>
        <th>操作</th>
    </tr>
    </thead>
</table>

<script>
    $(function() {
        var $transTable = $('#trans-table');

        var dataTable = $transTable.DataTable({
            processing: true,
            pageLength: 10,
            lengthChange: false,
            searching: true,
            serverSide: true,
            stateSave: true,
            ajax: {
                url: '/index/list',
                data: function ( d ) {
                    d.customer_code = "{{ customer_code }}";
                }
            },
            searchHighlight: true,
            select: {
                style:    'os',
                selector: 'td:first-child'
            },
            order: [
                [1, 'desc']
            ],
            columnDefs: [
                {
                    data: null,
                    defaultContent: '',
                    targets: 0,
                    orderable: false,
                    className: 'select-checkbox'
                },
                {
                    data: 'id',
                    targets: 1,
                    orderable: false
                },
                {
                    data: 'customer_code',
                    targets: 2,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    data: 'customer_name',
                    targets: 3,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    data: 'total_count',
                    targets: 4,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    data: 'total_balance',
                    targets:5,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    targets: 6,
                    data: 'customer_code',
                    orderable: false,
                    render: function (data, type, full, meta) {
                        var html = '<a target="_blank" href="/account/?customer_code='+ ""+ data.toString()  + "" + '" data-nopajx>查看帐号信息</a>';
                        html += '<span class="text-muted"> | </span>';
                        html += '<a target="_blank" href="/trans/?customer_code='+ ""+ data + "" + '" data-nopajx>查看交易明细</a>';
                        return html;
                    }
                }
            ],
            buttons: [
                {
                    text: '删除',
                    className: 'btn btn-default',
                    action: function () {
                        var ids = '';
                        var count = 0;

                        dataTable.rows({selected: true}).every( function () {
                            var d = this.data();
                            ids += d.id + ',';
                            count++;
                        });

                        if (count <= 0)
                        {
                            alert('请选择要删除的日志');
                            return false;
                        }

                        if (confirm("真的要删除这 "+ count +" 条日志吗？")) {
                            var url = '/command/delete?server_id=';
                            $.pjax({
                                url: url,
                                container: '#pjax-container',
                                type: 'POST',
                                data: {ids: ids},
                                push: false
                            });
                        }
                    }
                }
            ],
            initComplete: function(settings, json) {

            }
        });

        $transTable.on('click', 'tbody td a.stop', function () {
            var row = dataTable.row($(this).closest('tr'));
            var data = row.data();

            // 停止正在执行的任务
            if ($(this).hasClass('stop'))
            {
                if (!confirm('真的要停止 ID 为 ' + data.id + " 的命令吗？")) {
                    return false;
                }

                $.post($(this).attr('href'), function(data) {
                    if (data.state) {
                        success(data.message);
                    } else {
                        error(data.message);
                    }
                });

                return false;
            }
        });

    });
</script>