-- 고객 테이블
CREATE TABLE Owners (
    ownerID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(255)
);

-- 팻 테이블
CREATE TABLE Pets (
    petID INT AUTO_INCREMENT PRIMARY KEY,
    ownerID INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    breed VARCHAR(50) DEFAULT '소형견',
    weight INT NOT NULL CHECK (weight > 0),
    FOREIGN KEY (ownerID) REFERENCES Owners(ownerID)
);

-- 룸 테이블
CREATE TABLE Rooms (
    roomID INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(50) NOT NULL UNIQUE,
    room_class VARCHAR(50),
    room_price DECIMAL(10,2) NOT NULL CHECK (room_price >= 0)
);

-- 서비스 테이블
CREATE TABLE Services (
    serviceID INT AUTO_INCREMENT PRIMARY KEY,
    service_type VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

-- 예약 테이블
CREATE TABLE Reservations (
    reservationID INT AUTO_INCREMENT PRIMARY KEY,
    petID INT NOT NULL,
    roomID INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- 예약을 한 시간이 자동으로 기록됨
    CHECK (check_out > check_in),--체크아웃 시간이 체크인 시간보다 이후인 것을 확인
    FOREIGN KEY (petID) REFERENCES Pets(petID),
    FOREIGN KEY (roomID) REFERENCES Rooms(roomID)
);

-- 예약 옵션 : 본래는 예약에 통합했으나, 선택옵션의 경우 따로 빼는 쪽이 DB관리에 좋다고 GPT가 추천해줌
CREATE TABLE Reservation_Services (
    reservationID INT NOT NULL,
    serviceID INT NOT NULL,
    PRIMARY KEY (reservationID, serviceID),
    FOREIGN KEY (reservationID) REFERENCES Reservations(reservationID) ON DELETE CASCADE,--예약이 없어지면 서비스예약도 사라짐
    FOREIGN KEY (serviceID) REFERENCES Services(serviceID)
);


INSERT INTO Owners (name, phone_number) 
VALUES ('홍길동', '01012345678');

INSERT INTO Pets (ownerID, name, breed, weight)
VALUES (1, '복날이', '시고르자브종', 20);

INSERT INTO Rooms (room_number, room_class, room_price)
VALUES 
('101', '노말', 5),
('102', '노말', 5),
('201', '레어', 7),
('202', '레어', 7),
('301', '에픽', 10),
('302', '에픽', 10);

INSERT INTO Services (service_type, price)
VALUES 
('산책', 1),
('목욕', 2),
('미용', 3);

INSERT INTO Reservations (petID, roomID, check_in, check_out, created_at)
VALUES (1, 1, '2025-08-05', '2025-08-06', '2025-07-24 13:52:03');
--복날이가 101호에 8월 5일 부터 6일까지, 지금 예약함.


INSERT INTO Reservation_Services (reservationID, serviceID)
VALUES (1, 2);
--복날이의 목욕 서비스가 추가 됨