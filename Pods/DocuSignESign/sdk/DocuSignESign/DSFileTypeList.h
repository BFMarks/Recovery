#import <Foundation/Foundation.h>
#import "DSObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "DSFileType.h"


@protocol DSFileTypeList
@end

@interface DSFileTypeList : DSObject

/* A collection of file types. [optional]
 */
@property(nonatomic) NSArray<DSFileType>* fileTypes;

@end
