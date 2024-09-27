package config

import "github.com/spf13/viper"

var c Config

type Config struct {
	Port string
}

func Read() {
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.AddConfigPath(".")
	if err := viper.ReadInConfig(); err != nil {
		panic(err)
	}
	if err := viper.Unmarshal(&c); err != nil {
		panic(err)
	}
}

func Get() Config {
	return c
}
