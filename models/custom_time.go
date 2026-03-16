package models

import (
	"strings"
	"time"
)

type CustomTime struct {
	time.Time
}

// accepted incoming layouts from Angular (ISO date or ISO datetime)
var timeLayouts = []string{
	"02-01-2006 15:04",
	"2006-01-02T15:04:05Z07:00",
	"2006-01-02T15:04:05Z",
	"2006-01-02T15:04:05",
	"2006-01-02",
}

func (ct CustomTime) MarshalJSON() ([]byte, error) {
	if ct.IsZero() {
		return []byte(`""`), nil
	}
	return []byte(`"` + ct.Format("02-01-2006 15:04") + `"`), nil
}

func (ct *CustomTime) UnmarshalJSON(b []byte) error {
	s := strings.Trim(string(b), `"`)
	if s == "" || s == "null" {
		ct.Time = time.Time{}
		return nil
	}
	for _, layout := range timeLayouts {
		if t, err := time.Parse(layout, s); err == nil {
			ct.Time = t
			return nil
		}
	}
	return nil
}
