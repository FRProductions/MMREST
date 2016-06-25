from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Custom permission that allows full access to owners and read-only access to others.
    """

    def has_object_permission(self, request, view, obj):
        # read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # write permissions are only allowed to the owner
        return obj.user == request.user


class IsOwner(permissions.BasePermission):
    """
    Custom permission that allows full access to owners and no access to others.
    """

    def has_object_permission(self, request, view, obj):
        # permissions are only allowed to the owner
        return obj.user == request.user