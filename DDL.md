create table walk_your_dog.chat_room_participants
(
    room_id uuid,
    user_id uuid
);

alter table walk_your_dog.chat_room_participants
    owner to postgres;

create table walk_your_dog.chat_rooms
(
    id                uuid,
    type              varchar(20),
    last_message      text,
    last_message_time timestamp,
    created_at        timestamp
);

alter table walk_your_dog.chat_rooms
    owner to postgres;

create table walk_your_dog.club_members
(
    club_id uuid,
    user_id uuid
);

alter table walk_your_dog.club_members
    owner to postgres;

create table walk_your_dog.clubs
(
    id           uuid,
    name         varchar(100),
    description  text,
    type         varchar(20),
    region       varchar(100),
    target_breed varchar(50),
    owner_id     uuid,
    member_count integer,
    created_at   timestamp
);

alter table walk_your_dog.clubs
    owner to postgres;

create table walk_your_dog.market_item_images
(
    id        bigint,
    item_id   uuid,
    image_url text
);

alter table walk_your_dog.market_item_images
    owner to postgres;

create table walk_your_dog.market_items
(
    id          uuid,
    seller_id   uuid,
    title       varchar(100),
    category    varchar(50),
    price       numeric,
    lat         numeric,
    lng         numeric,
    status      varchar(20),
    description text,
    created_at  timestamp
);

alter table walk_your_dog.market_items
    owner to postgres;

create table walk_your_dog.messages
(
    id         uuid,
    room_id    uuid,
    sender_id  uuid,
    content    text,
    created_at timestamp
);

alter table walk_your_dog.messages
    owner to postgres;

create table walk_your_dog.pets
(
    id         uuid,
    user_id    uuid,
    name       varchar(50),
    breed      varchar(50),
    weight     numeric,
    birthdate  date,
    created_at timestamp
);

alter table walk_your_dog.pets
    owner to postgres;

create table walk_your_dog.users
(
    id          uuid,
    nickname    varchar(50),
    email       varchar(100),
    provider    varchar(20),
    provider_id varchar(100),
    total_dist  numeric,
    level       integer,
    created_at  timestamp
);

alter table walk_your_dog.users
    owner to postgres;

create table walk_your_dog.walk_pets
(
    walk_id uuid,
    pet_id  uuid
);

alter table walk_your_dog.walk_pets
    owner to postgres;

create table walk_your_dog.walks
(
    id              uuid,
    user_id         uuid,
    start_time      timestamp,
    end_time        timestamp,
    distance_meter  numeric,
    calories_burned numeric,
    created_at      timestamp
);

alter table walk_your_dog.walks
    owner to postgres;

