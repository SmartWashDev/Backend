from django.db import models


class CarWash(models.Model):
    photo_url = models.CharField(
        'Ссылка на фото',
        max_length=255,
    )
    plate_number = models.CharField(
        'Номерной знак',
        max_length=10,
        blank=True,
    )
    detected_at = models.DateTimeField(
        'Время заезда авто',
        auto_now=True,
    )
    recognized_at = models.DateTimeField(
        'Время распознавания номерного знака',
        null=True,
    )
    out_at = models.DateTimeField(
        'Время выезда авто',
        null=True,
    )
