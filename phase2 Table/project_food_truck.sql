drop schema if exists project_food_truck;
create schema if not exists project_food_truck;
use project_food_truck;

create table food_truck_user (
username char(50) not null,
firstname char(50) not null,
lastname char(50) not null,
user_password char(50) not null,
primary key (username),
unique key (firstname, lastname)
) engine = innodb;

create table food_truck_customer (
username char(50) not null,
balance decimal(6,2) not null,
station char(50),
primary key(username),
constraint fk1 foreign key (username) references food_truck_user (username)
) engine = innodb;

create table food_truck_employee (
username char(50) not null,
email char(50) not null,
primary key(username),
unique key (email),
constraint fk3 foreign key (username) references food_truck_user (username)
) engine = innodb;

create table food_truck_manager (
username char(50) not null,
primary key(username),
constraint fk4 foreign key (username) references food_truck_employee (username)
) engine = innodb;

create table food_truck_staff (
username char(50) not null,
food_truck char(50),
primary key(username),
constraint fk5 foreign key (username) references food_truck_employee (username)
) engine = innodb;

create table food_truck_admin (
username char(50) not null,
primary key(username),
constraint fk7 foreign key (username) references food_truck_employee (username)
) engine = innodb;

create table building (
building_name char(50) not null,
building_description char(200) not null,
primary key(building_name)
) engine = innodb;

create table food (
food_name char(50) not null,
primary key(food_name)
) engine = innodb;


create table station (
station_name char(50) not null,
capacity integer unsigned not null,
building char(50) not null,
primary key(station_name),
unique key(building)
) engine = innodb;

create table food_truck_order (
orderid char(50) not null,
order_date date not null,
customer char(50) not null,
primary key(orderid)
) engine = innodb;

create table menu_item (
food_truck char(50) not null,
food char(50) not null,
price decimal(6,2) not null,
primary key(food_truck, food)
) engine = innodb;

create table food_truck (
food_truck_name char(50) not null,
station char(50) not null,
manager char(50) not null,
primary key(food_truck_name)
) engine = innodb;

create table order_contain (
orderid char(50) not null,
food_truck char(50),
food char(50),
purchase_quantity integer unsigned,
primary key(orderid, food_truck, food)
)engine = innodb;

create table tag (
building char(50) not null,
tag_name char(50) not null,
primary key(building, tag_name),
constraint fk17 foreign key (building) references building (building_name)
)engine = innodb;

alter table food_truck_customer add constraint fk2 foreign key (station) references station (station_name);
alter table food_truck_staff add constraint fk6 foreign key (food_truck) references food_truck (food_truck_name);
alter table station add constraint fk8 foreign key (building) references building (building_name);
alter table food_truck_order add constraint fk9 foreign key (customer) references food_truck_customer (username);
alter table menu_item add constraint fk10 foreign key (food_truck) references food_truck (food_truck_name);
alter table menu_item add constraint fk11 foreign key (food) references food (food_name);
alter table food_truck add constraint fk12 foreign key (station) references station (station_name);
alter table food_truck add constraint fk13 foreign key (manager) references food_truck_manager (username);
alter table order_contain add constraint fk14 foreign key (orderid) references food_truck_order (orderid);
alter table order_contain add constraint fk15 foreign key (food_truck) references food_truck (food_truck_name);
alter table order_contain add constraint fk16 foreign key (food) references food (food_name);

-- building
insert into building values
('Clough', 'Has starbucks; located near to transit hub'),
('College of Computing', 'Famously called as CoC'),
('CrossLand Tower', 'Library'),
('KLAUS Adv Computing', 'Connected to CoC through binary bridge'),
('Molecular Engineering', 'Hosts classes for molecular engineering'),
('Skiles', 'Host classes for media and literature students'),
('Students_Center', 'Host for student activities'),
('TechTower', 'Most Iconic building'),
('Weber Building', 'Classes mostly related to space technology');

-- tags
insert into tag values
('Clough','ADA'),
('Clough','Labs'),
('Clough','LEED'),
('College of Computing','Computing'),
('CrossLand Tower','LEED'),
('CrossLand Tower','Library'),
('KLAUS Adv Computing', 'Computing'),
('Molecular Engineering', 'Engineering'),
('Skiles', 'Liberal Arts'),
('Students_Center', 'LEED'),
('TechTower', 'ADA'),
('TechTower', 'Registrar'),
('Weber Building', 'ADA'),
('Weber Building', 'Sciences');

-- stations
insert into station values
('Clough Commons', '20', 'Clough'),
('CoC Court Yard', '15', 'College of Computing'),
('Bio Quad', '20', 'Molecular Engineering'),
('Skiles Walkway', '3', 'Skiles'),
('Campanile', '7', 'Students_Center');

-- food
insert into food values
('Bagels'),
('CeasarSalad'),
('CheeseBurger'),
('ChickenSandwich'),
('ChickenTacos'),
('ChickenWings'),
('ChocolateShake'),
('ElkBurger'),
('HamBurger'),
('HotDog'),
('MargheritaPizza'),
('Nachos'),
('Noodles'),
('Pie'),
('SalmonTacos'),
('Shawarma'),
('ShrimpGumbo'),
('SouthWestChickenSalad'),
('TrailMix'),
('VegetarianGumbo'),
('VegetarianTacos'),
('VegPizza'),
('VegSpringRolls'),
('Waffles');

-- user
insert into food_truck_user values
('2Cool_not_todoschool', 'Smarty', 'Pants', '4242424242'),
('4400_thebestclass', 'Seriously', 'Itis', '4400440044'),
('Aturning_Machine12', 'Alan', 'Turing', '3333333333'),
('beBatman!','Bruce','Wayne','5555555555'),
('bestfriends4ever1','C3P0','Droid','44444444433'),
('bestfriends4ever2','R2D2','Droid','44444444443'),
('BuzzyAsAYellowJacket','Buzz','Buzz','1010101010'),
('coxRaycox','Ray','Cox','4242424242'),
('customer1','One','One','1111111111'),
('customer2','Two','Two','1011111111'),
('deer.john','John','Deer','22222022222'),
('doe.jane','Jane','Doe','22222222200'),
('doe.john','John','Doe','20000000002'),
('EmmsBest','Emma','Williams','1000000011'),
('employee1','Employee','Won','1000111111'),
('Employeeofthemonth','Beast','Boy','1000011111'),
('FatherofInfoTheory','Claude','Shannon','2222222222'),
('ILikeFlowers','Lily','Rose','1000000001'),
('JHallPride','James','Hall','2222222222'),
('JNash28TheoryofGaming','John','Nash','1111111111'),
('LadyVader1977','Leia','Organa','54545454545'),
('LifeIsLikeABoxOfChoco.','Forrest','Gump','4444444444'),
('LifeUniverseEverything','Forty','Two','4242424242'),
('Manager1','First','Manager','1000001111'),
('Manager2','Second','Manager','1000000111'),
('Manager3','Third','Manager','1000000011'),
('Manager4','Fourth','Manager','1000000001'),
('mKJerrY', 'Mike','Jerry','22222022222'),
('Nekonsh', 'Nelsh','Kong','8888888888'),
('RPosince','Prince','Ross','2222222222'),
('RRanskans','Ruby','Rans','44444444433'),
('scoRa','Dhey','Scott','7000000000'),
('sffrgerge','Blah','BlahBlah','1000000000'),
('SShen','Soms', 'Shen', '4444444444'),
('Staff1','One','Staff','3333333333'),
('Staff2', 'Two', 'Staff', '2222222222'),
('notmybusiness', 'Kermit', 'TheFrog','7000000000'),
('theCustomersAlwaysRight', 'Always','Everytime','1001111111'),
('thereal_GPBurdell', 'George','Burdell','9999999999'),
('TingTong', 'Eva', 'Bell', '1000000000'),
('tkingTom', 'Tom', 'King', '2222222222'),
('TooCuteNottoMention', 'Baby', 'Yoda','8888888888'),
('toongNonyLongy','Tony','Long','20000000002'),
('Violax','Violet','Lax','4400440044'),
('WomanWhoSmashedCode','Elizabeth','Friedman','4444444444'),
('YayVish','Vishy','Yay','6666666666'),
('YouBetterBeNiceToMe','Talking', 'Tina', '6666666666');

-- customer
insert into food_truck_customer values
('4400_thebestclass','44','Clough Commons'),
('beBatman!','89.99','Skiles Walkway'),
('BuzzyAsAYellowJacket','0.5','Skiles Walkway'),
('coxRaycox','4.5','CoC Court Yard'),
('customer1','46.99','Clough Commons'),
('customer2','47','CoC Court Yard'),
('JHallPride','30.9','Clough Commons'),
('LifeUniverseEverything','42.42','Campanile'),
('mKJerrY','44.2','Bio Quad'),
('RPosince','67.89','Campanile'),
('RRanskans','7.78','Bio Quad'),
('sffrgerge','4.09','Clough Commons'),
('notmybusiness','19.55','Bio Quad'),
('theCustomersAlwaysRight','2.99','CoC Court Yard'),
('TingTong','50.25','Bio Quad'),
('tkingTom','70.14','Skiles Walkway'),
('toongNonyLongy','17.9','Clough Commons'),
('Violax','15.2','Skiles Walkway'),
('YouBetterBeNiceToMe','52.63','Bio Quad');


-- Employee
insert into food_truck_employee values
('2Cool_not_todoschool', 'school@gmail.com'),
('4400_thebestclass', '4400_thebestclass@gatech.edu'),
('Aturning_Machine12', 'machine12@outlook.com'),
('beBatman!','beBatman!@gatech.edu'),
('bestfriends4ever1', 'bff@hotmail.com'),
('bestfriends4ever2', 'bff2@gmail.com'),
('BuzzyAsAYellowJacket', 'BuzzyAsAYellowJacket@gatech.edu'),
('deer.john', 'dj3@outlook.com'),
('doe.jane', 'dj1@outlook.com'),
('doe.john', 'dj2@outlook.com'),
('EmmsBest', 'emmsbest@gatech.edu'),
('employee1','employee1@gatech.edu'),
('Employeeofthemonth', 'Employeeofthemonth@gatech.edu'),
('FatherofInfoTheory', 'fot@gmail.com'),
('ILikeFlowers', 'flora@gatech.edu'),
('JNash28TheoryofGaming', 'jg@hotmail.com'),
('LadyVader1977', 'lv1977@gatech.edu'),
('LifeIsLikeABoxOfChoco.', 'chocolate@gmail.com'),
('Manager1', 'manager1@gatech.edu'),
('Manager2', 'manager2@gatech.edu'),
('Manager3', 'manager3@gatech.edu'),
('Manager4', 'manager4@gatech.edu'),
('Nekonsh', 'nekonsh@gatech.edu'),
('RRanskans', 'rranskans@gatech.edu'),
('scoRa', 'scoRa@gatech.edu'),
('sffrgerge', 'sff@outlook.com'),
('SShen', 'sshen@gatech.edu'),
('Staff1', 'staff1@gatech.edu'),
('Staff2', 'staff2@gatech.edu'),
('thereal_GPBurdell', 'gpb@gatech.edu'),
('TingTong', 'tingtong@gatech.edu'),
('TooCuteNottoMention', 'mention@gmail.com'),
('Violax', 'violax@gatech.edu'),
('WomanWhoSmashedCode', 'smashedcode@gmail.com'),
('YayVish', 'yayvish@gatech.edu');

-- Manager
insert into food_truck_manager values
('doe.jane'),
('FatherofInfoTheory'),
('LadyVader1977'),
('LifeIsLikeABoxOfChoco.'),
('Manager1'),
('Manager2'),
('Manager3'),
('Manager4'),
('SShen'),
('thereal_GPBurdell'),
('YayVish');

-- Food truck
insert into food_truck values
('BurgerBird', 'Clough Commons', 'LadyVader1977'),
('FourAnalystInATacoTruck', 'Clough Commons', 'FatherofInfoTheory'),
('GoodFoodTruck', 'CoC Court Yard', 'FatherofInfoTheory'),
('WaffleTruffle', 'CoC Court Yard','SShen'),
('GoodOnAStudentBudget', 'Bio Quad', 'thereal_GPBurdell'),
('ShawarmaExpress', 'Bio Quad', 'Manager3'),
('FoodTrolley', 'Skiles Walkway', 'LadyVader1977'),
('BubbaGumps', 'Campanile', 'LifeIsLikeABoxOfChoco.'),
('CrazyPies', 'Campanile', 'Manager1'),
('FoodTruckYoureLookingFor', 'Campanile', 'LadyVader1977'),
('FusionFoodTruck', 'Campanile', 'YayVish'),
('JohnJaneAndVenison', 'Campanile', 'doe.jane'),
('NachoBizness', 'Campanile', 'Manager2'),
('TruckOfFood', 'Campanile', 'Manager2');

-- Staff
insert into food_truck_staff values
('2Cool_not_todoschool', 'WaffleTruffle'),
('Aturning_Machine12', 'FourAnalystInATacoTruck'),
('beBatman!', 'WaffleTruffle'),
('bestfriends4ever1', 'FoodTruckYoureLookingFor'),
('bestfriends4ever2', 'BurgerBird'),
('BuzzyAsAYellowJacket', 'ShawarmaExpress'),
('deer.john', 'JohnJaneAndVenison'),
('doe.john', 'TruckOfFood'),
('EmmsBest', 'CrazyPies'),
('employee1', 'BurgerBird'),
('Employeeofthemonth', 'ShawarmaExpress'),
('ILikeFlowers', 'CrazyPies'),
('JNash28TheoryofGaming', 'GoodFoodTruck'),
('RRanskans', 'FoodTrolley'),
('sffrgerge', 'GoodOnAStudentBudget'),
('Staff1', 'BubbaGumps'),
('Staff2', 'BubbaGumps'),
('TingTong', 'FusionFoodTruck'),
('TooCuteNottoMention', 'NachoBizness'),
('Violax', 'FoodTrolley'),
('WomanWhoSmashedCode', 'FourAnalystInATacoTruck');

-- Admin
insert into food_truck_admin values
('4400_thebestclass'),
('Nekonsh'),
('scoRa');



-- Order(!)
insert into food_truck_order values
('0000000001', '2020/1/1', 'customer1'),
('0000000002', '2020/1/1', 'customer1'),
('0000000003', '2020/1/1', 'customer2'),
('0000000004', '2020/2/1', 'customer2'),
('0000000005', '2020/2/2', 'customer1'),
('0000000006', '2020/2/3', 'customer2'),
('0000000007', '2020/2/4', 'theCustomersAlwaysRight'),
('0000000008', '2020/2/4', 'theCustomersAlwaysRight'),
('0000000009', '2020/2/4', 'notmybusiness'),
('0000000010', '2020/2/4', 'customer1'),
('0000000011', '2020/2/5', 'customer2'),
('0000000012', '2020/2/5', 'theCustomersAlwaysRight'),
('0000000013', '2020/2/5', 'notmybusiness'),
('0000000014', '2020/2/5', 'notmybusiness'),
('0000000015', '2020/2/6', 'notmybusiness'),
('0000000016', '2020/2/6', 'theCustomersAlwaysRight'),
('0000000017', '2020/2/6', 'notmybusiness'),
('0000000018', '2020/2/10', 'customer1'),
('0000000019', '2020/2/10', 'customer2'),
('0000000020', '2020/2/10', 'customer2'),
('0000000021', '2020/2/10', 'customer2'),
('0000000022', '2020/2/10', 'BuzzyAsAYellowJacket'),
('0000000023', '2020/2/10', 'BuzzyAsAYellowJacket'),
('0000000024', '2020/2/10', 'customer1'),
('0000000025', '2020/2/10', 'customer2'),
('0000000026', '2020/2/11', 'BuzzyAsAYellowJacket'),
('0000000027', '2020/2/11', 'customer2'),
('0000000028', '2020/2/22', 'customer2'),
('0000000029', '2020/2/29', 'customer2'),
('0000000030', '2020/2/29', 'customer1'),
('0000000031', '2020/3/1', 'customer1'),
('0000000032', '2020/3/1', 'customer2'),
('0000000033', '2020/3/1', 'customer2'),
('0000000034', '2020/3/1', 'sffrgerge'),
('0000000035', '2020/3/1', 'sffrgerge'),
('0000000036', '2020/3/1', 'customer1'),
('0000000037', '2020/3/1', 'LifeUniverseEverything'),
('0000000038', '2020/3/1', 'beBatman!'),
('0000000039', '2020/3/1', 'beBatman!'),
('0000000040', '2020/3/1', 'YouBetterBeNiceToMe'),
('0000000041', '2020/3/1', 'YouBetterBeNiceToMe');

-- menu_item
insert into menu_item values
('GoodOnAStudentBudget', 'CeasarSalad', '3.46'),
('BurgerBird', 'CheeseBurger', '4.76'),
('GoodOnAStudentBudget', 'CheeseBurger', '4.51'),
('BubbaGumps', 'ChickenTacos', '5.21'),
('FourAnalystInATacoTruck', 'ChickenTacos', '6.22'),
('NachoBizness', 'ChickenTacos', '6.58'),
('FoodTrolley', 'ChickenWings', '6.01'),
('FourAnalystInATacoTruck', 'ChickenWings', '5.28'),
('FoodTrolley', 'ChocolateShake', '7.54'),
('GoodOnAStudentBudget', 'ChocolateShake', '5.48'),
('ShawarmaExpress', 'ChocolateShake', '4.85'),
('BurgerBird', 'ElkBurger', '6.68'),
('JohnJaneAndVenison', 'ElkBurger', '10.17'),
('BurgerBird', 'HamBurger', '7.05'),
('GoodOnAStudentBudget', 'HamBurger', '3.82'),
('GoodOnAStudentBudget', 'HotDog', '2.23'),
('CrazyPies', 'MargheritaPizza', '4.28'),
('FoodTruckYoureLookingFor', 'MargheritaPizza', '7.58'),
('FoodTruckYoureLookingFor', 'Nachos', '3.21'),
('NachoBizness', 'Nachos', '5.13'),
('GoodFoodTruck', 'Noodles', '4.40'),
('TruckOfFood', 'Noodles', '4.77'),
('BurgerBird', 'Pie', '4.53'),
('CrazyPies', 'Pie', '4.19'),
('FoodTrolley', 'Pie', '4.51'),
('FourAnalystInATacoTruck', 'SalmonTacos', '8.03'),
('FusionFoodTruck', 'SalmonTacos', '7.16'),
('NachoBizness', 'SalmonTacos', '7.59'),
('ShawarmaExpress', 'Shawarma', '6.30'),
('BubbaGumps', 'ShrimpGumbo', '6.22'),
('FoodTruckYoureLookingFor', 'SouthWestChickenSalad', '9.57'),
('GoodFoodTruck', 'SouthWestChickenSalad', '9.06'),
('JohnJaneAndVenison', 'TrailMix', '4.36'),
('BubbaGumps', 'VegetarianGumbo', '3.82'),
('FourAnalystInATacoTruck', 'VegetarianTacos', '5.84'),
('FusionFoodTruck', 'VegetarianTacos', '5.95'),
('NachoBizness', 'VegetarianTacos', '4.70'),
('CrazyPies', 'VegPizza', '3.48'),
('FoodTruckYoureLookingFor', 'VegPizza', '7.88'),
('GoodFoodTruck', 'VegSpringRolls', '3.11'),
('TruckOfFood', 'VegSpringRolls', '3.53'),
('FoodTrolley', 'Waffles', '5.82'),
('GoodOnAStudentBudget', 'Waffles', '3.44'),
('WaffleTruffle', 'Waffles', '6.65');

-- Order_contain
insert into order_contain values
('0000000001', 'CrazyPies', 'MargheritaPizza', '1'),
('0000000001', 'CrazyPies', 'Pie', '2'),
('0000000001', 'CrazyPies', 'VegPizza', '1'),
('0000000002', 'GoodOnAStudentBudget', 'CeasarSalad', '1'),  
('0000000002', 'GoodOnAStudentBudget', 'HotDog', '1'),
('0000000003', 'GoodOnAStudentBudget', 'CheeseBurger', '1'), 
('0000000003', 'GoodOnAStudentBudget', 'HamBurger', '1'),
('0000000003', 'GoodOnAStudentBudget', 'Waffles', '2'),
('0000000004', 'FoodTrolley', 'ChickenWings' , '4'),
('0000000005', 'NachoBizness', 'SalmonTacos', '3'),
('0000000006', 'FourAnalystInATacoTruck', 'ChickenTacos', '3'), 
('0000000006', 'FourAnalystInATacoTruck', 'ChickenWings', '4'),
('0000000006', 'FourAnalystInATacoTruck', 'SalmonTacos', '1'),
('0000000007', 'BurgerBird', 'ElkBurger', '2'),
('0000000007', 'BurgerBird', 'HamBurger', '2'),
('0000000008', 'ShawarmaExpress', 'Shawarma', '2'),
('0000000009', 'JohnJaneAndVenison', 'TrailMix', '2'),
('0000000010', 'TruckOfFood', 'Noodles', '1'),  
('0000000010', 'TruckOfFood', 'VegSpringRolls', '3'),
('0000000011', 'NachoBizness', 'ChickenTacos', '1'),
('0000000011', 'NachoBizness', 'Nachos', '4'),
('0000000011', 'NachoBizness', 'SalmonTacos', '3'),
('0000000011', 'NachoBizness', 'VegetarianTacos', '3'),
('0000000012', 'FoodTruckYoureLookingFor', 'MargheritaPizza', '2'),
('0000000012', 'FoodTruckYoureLookingFor', 'VegPizza', '2'),
('0000000013', 'FoodTrolley', 'ChocolateShake', '1'),
('0000000014', 'GoodOnAStudentBudget', 'HamBurger', '4'),
('0000000015', 'FoodTrolley', 'ChickenWings', '1'),
('0000000016', 'FoodTrolley', 'ChickenWings', '2'),
('0000000017', 'ShawarmaExpress', 'Shawarma', '6'),
('0000000018', 'WaffleTruffle', 'Waffles', '4'),
('0000000019', 'FourAnalystInATacoTruck', 'VegetarianTacos', '3'),
('0000000020', 'FourAnalystInATacoTruck', 'ChickenWings', '1'),
('0000000020', 'FourAnalystInATacoTruck', 'VegetarianTacos', '2'),
('0000000021', 'GoodOnAStudentBudget', 'CheeseBurger', '1'), 
('0000000021', 'GoodOnAStudentBudget', 'ChocolateShake', '1'),
('0000000021', 'GoodOnAStudentBudget', 'HamBurger', '3'),
('0000000022', 'GoodOnAStudentBudget', 'CeasarSalad', '5'),    
('0000000022', 'GoodOnAStudentBudget', 'CheeseBurger', '1'),
('0000000022', 'GoodOnAStudentBudget', 'HotDog', '1'),
('0000000022', 'GoodOnAStudentBudget', 'Waffles', '3'),
('0000000023', 'GoodOnAStudentBudget', 'ChocolateShake', '2'),
('0000000023', 'GoodOnAStudentBudget', 'HamBurger', '1'),
('0000000024', 'TruckOfFood', 'Noodles', '1'), 
('0000000024', 'TruckOfFood', 'VegSpringRolls','5'),
('0000000025', 'BurgerBird', 'Pie', '1'),
('0000000026', 'FoodTrolley', 'ChickenWings', '6'),
('0000000026', 'FoodTrolley', 'ChocolateShake', '2'),
('0000000026', 'FoodTrolley', 'Pie', '1'),
('0000000026', 'FoodTrolley', 'Waffles', '2'),
('0000000027', 'FoodTruckYoureLookingFor', 'VegPizza', '1'),
('0000000028', 'BurgerBird', 'CheeseBurger', '1'),
('0000000029', 'FourAnalystInATacoTruck', 'ChickenWings', '6'),
('0000000030', 'BubbaGumps', 'VegetarianGumbo', '1'),
('0000000031', 'FourAnalystInATacoTruck', 'ChickenTacos', '3'),
('0000000031', 'FourAnalystInATacoTruck', 'ChickenWings', '5'),
('0000000031', 'FourAnalystInATacoTruck', 'SalmonTacos', '3'),
('0000000031', 'FourAnalystInATacoTruck', 'VegetarianTacos', '1'),
('0000000032',	'BurgerBird','CheeseBurger','3'), 
('0000000032',	'BurgerBird','Pie','1'),
('0000000033',	'FoodTrolley','ChickenWings','5'),
('0000000033',	'FoodTrolley','Pie','1'),
('0000000033',	'FoodTrolley','Waffles','2'),
('0000000034',	'FourAnalystInATacoTruck', 'ChickenTacos', '3'),  
('0000000034',	'FourAnalystInATacoTruck', 'ChickenWings', '5'),
('0000000034',	'FourAnalystInATacoTruck', 'SalmonTacos', '3'),
('0000000035',	'GoodOnAStudentBudget',	'CeasarSalad', '2'),  
('0000000035',	'GoodOnAStudentBudget',	'Waffles', '1'),
('0000000036',	'GoodOnAStudentBudget',	'ChocolateShake', '1'),
('0000000036',	'GoodOnAStudentBudget',	'HamBurger', '1'),
('0000000037',	'BurgerBird', 'CheeseBurger', '1'),
('0000000038',	'BubbaGumps', 'ChickenTacos', '7'),
('0000000039',	'NachoBizness',	'Nachos', '2'),
('0000000040',	'CrazyPies', 'MargheritaPizza', '1'),
('0000000040',	'CrazyPies', 'VegPizza', '1'),
('0000000041',	'BubbaGumps', 'ChickenTacos', '1'),
('0000000041',	'BubbaGumps',  'ShrimpGumbo', '1'),
('0000000041',	'BubbaGumps',  'VegetarianGumbo', '1');


