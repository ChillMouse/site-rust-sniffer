<?php

$search = $_GET['pincode']; // Пароль для поиска по базе


// Если аргумент не был передан
if (strlen($search) != 4 && isset($search)) {
    http_response_code(400);
    echo json_encode(array('data' => 'error', 'status' => 400, 'error' => 'don\'t gave arguments'));
    exit(400);
}

// Проверка RegExp [1-9]{4}
$match = preg_match('/[1-9]{4}/', $search);
if ($match === false) {
    http_response_code(400);
    echo json_encode(array('data' => 'error', 'status' => 400, 'error' => 'argument haven\'t'));
    exit(400);
}
if ($match === 0) {
    http_response_code(400);
    echo json_encode(array('data' => 'error', 'status' => 400, 'error' => 'argument contains extra characters or no argument'));
    exit(400);
}


try{
    $db = new mysqli();
    $db->connect('localhost', 'mysql', 'mysql', 'rust', '3306');
    $db->set_charset('utf8_general_ci');
    $result = $db->query("SELECT * FROM `codes` WHERE `code` LIKE '$search'");


    // Если найдено значение в БД
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            http_response_code(200);
            echo json_encode(array('data' => $row, 'status' => 200));
        }
    }
    else {
        $res_collected = $db->query("SELECT * FROM `collected_codes` WHERE `code` LIKE '$search'");
        // Если уже был такой код, то прибавим единицу, иначе создадим запись
        if ($res_collected->num_rows > 0) {
            $count = intval($res_collected->fetch_assoc()['count']);
            $count++;
            $db->query("UPDATE `collected_codes` SET `count` = '$count' WHERE `code` LIKE '$search'");
            http_response_code(200);
            echo json_encode(array('data' => 'success', 'status' => 200));
            exit(200);
        }
        else {
            $db->query("INSERT INTO `collected_codes` (`code`) VALUES ('$search')");
            http_response_code(200);
            echo json_encode(array('data' => 'success', 'status' => 200));
            exit(200);
        }
    } // В ином случае проверяем, есть ли значение и прибавляем единицу, либо заносим в базу
    $db->close();
}

// Если была ошибка при подключении БД
catch (Exception $e){
    http_response_code(500);
    echo json_encode(array('data' => 'error', 'status' => 500));
    exit(500);
}

// Если в БД не найден код
if ($result->num_rows === 0) {
    echo json_encode(array('data' => 'error', 'status' => 204, 'error' => 'don\'t found'));
}
