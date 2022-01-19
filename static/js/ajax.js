    $(function () {
            let btn = $('#btn');
            let block = $('#response');
            let inpt = $('#pincode-value');
            let hdn_btn = $('#hidden_button');

            $(document).keydown(function (e) {
                if ((e.key === 'Enter')) {
                    btn.click();
                    //console.info('Pressed Enter');
                    return false;
                }
            });
            $('body').bind('copy paste cut', function (e) {
                e.preventDefault();
            });

            function request() {
                $.ajax(
                    {
                        url: "/api/scan.php",

                        method: "get",

                        data: $("#pincode").serialize(),

                        success: function (data) {

                            let result = $.parseJSON(data);

                            //console.log(result);
                            if (result.status === 200) {
                                $(block).text('Пароль был найден. Он в руках злоумыленников. Вы можете защитить ваш пароль удалением его из базы. Для этого нажмите на кнопку "Скрыть пароль"').css({
                                    'background': 'red',
                                    'color': 'white'
                                });
                                $(hdn_btn).css('display', 'block');
                            } else {
                                $(hdn_btn).css('display', 'none');
                            }


                            //console.log("Script success");

                            let text = "";

                            if (result.data === 'error') {
                                switch (result.status) {

                                    case 204:
                                        text = 'Код не был найден в базе данных.';
                                        $(block).text(text).css({'background': 'green', 'color': 'white'})
                                        //console.error(text);
                                        break;

                                    case 400:
                                        text = result.error;
                                        $(block).text(text).css({'background': 'red', 'color': 'white'})
                                        //console.error(text);
                                        break;

                                    case 500:
                                        text = 'Ошибка, связання с базой данных. Поиск не был выполнен.';
                                        $(block).text(text).css({'background': 'red', 'color': 'white'})
                                        //console.error(text);
                                        break;
                                }
                            }
                        },

                        error: function () {
                            $(block).text('При выполнении запроса произошла ошибка. Попробуйте выполнить проверку позже.').css({
                                'background': 'red',
                                'color': 'white'
                            });
                            //console.log("Error AJAX");
                        },

                        complete: function () {
                            //console.log("Script completed");
                            //console.timeEnd('AJAX');
                            //console.groupEnd();
                        }
                    }
                );
            }

            $(btn).click(function () {
                //console.group('AJAX');
                //console.time('AJAX');

                const reg = new RegExp(/[1-9]{4}/);
                const code = $(inpt).val();

                if (code.length === 4 && code.match(reg)) {
                    //console.info('Пароль был отправлен на проверку');
                    $(block).text('Пароль был отправлен на проверку').css({'background': 'green', 'color': 'white'});
                    request();
                } else {
                    //console.error('Пароль не прошёл проверку, убедитесь в правильности ввода. 4 цифры, без нулей.');
                    $(block).text('Пароль не прошёл проверку, убедитесь в правильности ввода. 4 цифры, без нулей.').css({
                        'background': 'red',
                        'color': 'white'
                    });
                }
            });
        }
    );