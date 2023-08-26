from fastapi import status
from fastapi.responses import Response
from pydantic import BaseModel



class DocumentedResponse:
    def __init__(self, status_code, description, model=None):
        self.status_code = status_code
        self.description = description
        self.model = model
    def documentation(self):
        return {
            'description': self.description,
        }
    def response(self):
        return Response(
            status_code=self.status_code,
        )

class JSONDocumentedResponse(DocumentedResponse):
    
    def response(self, data: BaseModel | dict=None, exclude: set=set()):
        return Response(
            content=data if not self.model else data.json(exclude_none=True, exclude=exclude),
            status_code=self.status_code,
            media_type='application/json',
        )
    
JDR = JSONDocumentedResponse


class MediaDocumentedResponse(DocumentedResponse):

    def __init__(self, status_code, description, media_type, model=None):
        super(MediaDocumentedResponse, self).__init__(status_code, description, model)
        self.media_type = media_type

    def response(self, data):
        return Response(
            content=data,
            status_code=self.status_code,
            media_type=self.media_type,
        )

def create_documentation(responses: list[DocumentedResponse]):
    documentation = {}
    documentation['status_code'] = responses[0].status_code
    documentation['response_description'] = responses[0].description
    if responses[0].model:
        documentation['response_model'] = responses[0].model
    documentation['responses'] = {}
    for response in responses[1:]:
        doc = response.documentation()
        if response.model:
            doc['model'] = response.model
        documentation['responses'][response.status_code] = doc

    return documentation


success_response = JDR(status.HTTP_204_NO_CONTENT, 'Success')
failed_response = JDR(status.HTTP_400_BAD_REQUEST, 'Failed')

forbidden_jdr = JSONDocumentedResponse(
    status.HTTP_403_FORBIDDEN,
    'You do not have permission to perform this action.',
)

not_found_jdr = JSONDocumentedResponse(
    status.HTTP_404_NOT_FOUND,
    'Resource not found.',
)