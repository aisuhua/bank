{{ content() }}
{{ flashSession.output() }}

<ol class="breadcrumb">
    <li><a href="/">首页</a></li>
    <li><a href="/account/?customer_code={{ customer.customer_code }}" class="active">{{ customer.customer_name }}的账户查询</a></li>
</ol>

<div class="panel panel-default">
    <div class="panel-heading">{{ customer.customer_name }}</div>
    <div class="panel-body">
        {{ customer.profile  }}
    </div>
</div>

<table id="trans-table" class="table table-bordered table-hover">
    <thead>
    <tr>
        <th></th>
        <th>编号</th>
        <th>账号</th>
        <th>开户行</th>
        <th>余额</th>
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
            searching: false,
            serverSide: true,
            stateSave: true,
            ajax: {
                url: '/account/list',
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
                    data: 'acc_number',
                    targets: 2,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    data: 'open_org',
                    targets: 3,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
                    }
                },
                {
                    data: 'balance',
                    targets: 4,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return data;
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