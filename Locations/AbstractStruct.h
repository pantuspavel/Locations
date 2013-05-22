//
//  AbstractStruct.h
//  Locations
//
//  Created by Pavel Pantus on 5/13/13.
//  Copyright (c) 2013 Unison Technologies. All rights reserved.
//

enum StructType {
    TAuthDataStruct,
    TServerConfigStruct,
    TAccountDetailsStruct,
    TAccountStruct,
    TAccountsStruct,
    TAccountShortStruct,
    TAccountsShortStruct,
    TOrganizationStruct,
    TContactDetailsStruct,
    TContactStruct,
    TContactsStruct,
    TServerErrorStruct,
    TServerErrorsStruct,
    TAttachmentMetaInfoStruct,
    TAttachmentPreviewStruct,
    TAttachmentPreviewsStruct,
    TAttachmentStruct,
    TAttachmentsStruct,
    TChatMessageStruct,
    TChatMessagesStruct,
    TWallStruct,
    TTopicStruct,
    TCommentStruct,
    TWallMentionStruct,
    TSapogDropStruct,
    TSapogStartStruct,
    TSapogWaitStruct,
    TSapogAnsweredStruct,
    TSapogAcknowlegeStruct,
    TSapogUpdateStruct,
    TSapogInitStruct,
    TSapogAcceptStruct,
    TSapogReInitStruct,
    TSapogReInitConfirmStruct
};

@protocol AbstractStruct <NSObject>
@property (nonatomic, assign, readonly) enum StructType type;
- (BOOL)isValid;
- (void)fillFromJson:(id)json;
- (id)value;

@end
