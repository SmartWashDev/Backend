from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.viewsets import ReadOnlyModelViewSet

from apps.car_wash.models import CarWash
from apps.car_wash.serializers import CarWashSerializer


class CarWashViewSet(ReadOnlyModelViewSet):
    queryset = CarWash.objects.all()
    serializer_class = CarWashSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {
        'plate_number': ['exact', 'in'],
        'detected_at': ['lte', 'gte', 'gt', 'lt', 'exact', 'in'],
        'recognized_at': ['lte', 'gte', 'gt', 'lt', 'exact', 'in'],
        'out_at': ['lte', 'gte', 'gt', 'lt', 'exact', 'in'],
    }
