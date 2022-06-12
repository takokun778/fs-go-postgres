package main

import (
	"context"
	"database/sql"
	"log"

	"fs-go-postgres/entity"

	_ "github.com/lib/pq"
	"github.com/volatiletech/sqlboiler/v4/boil"
)

func main() {
	db, err := sql.Open("postgres", "host=localhost port=15432 user=postgres password=postgres dbname=postgres sslmode=disable")

	defer func() {
		if err := db.Close(); err != nil {
			log.Fatal(err.Error())
		}
	}()

	if err != nil {
		log.Fatal(err.Error())
	}

	user := entity.User{
		Name: "rei",
		Age:  22,
	}

	err = user.Insert(context.Background(), db, boil.Infer())

	if err != nil {
		log.Fatal(err.Error())
	}

	entities, err := entity.FindUser(context.Background(), db, 1)

	if err != nil {
		log.Fatal(err.Error())
	}

	log.Printf("%+v", entities)
}
