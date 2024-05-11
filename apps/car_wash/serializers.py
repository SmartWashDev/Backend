from rest_framework import serializers

from apps.car_wash.models import CarWash


class CarWashSerializer(serializers.ModelSerializer):
    class Meta:
        model = CarWash
        fields = '__all__'
